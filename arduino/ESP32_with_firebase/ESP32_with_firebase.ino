#include <WiFi.h>
#include <Firebase_ESP_Client.h>
#include <OneWire.h>
#include <DallasTemperature.h>
#include <MQ135.h>
#include <DFRobot_PH.h>
#include <DFRobot_ESP_PH.h>

#include "addons/TokenHelper.h"
#include "addons/RTDBHelper.h"

#define WIFI_SSID "POCO F4"
#define WIFI_PASSWORD "123nau123"

#define API_KEY "AIzaSyBN2McacTs5kKbfS2Lc5umzutLqZkHuQso"
#define DATABASE_URL "https://ta-capstone-22597-default-rtdb.asia-southeast1.firebasedatabase.app/"

#define ONE_WIRE_BUS 2
#define MQ_sensor 33
#define TDS_Pin 32
#define PH_PIN 34
#define sensorPin A0

#define RL 10
#define m -0.417
#define b 0.425
#define Ro 13
#define ESPADC 4096.0
#define ESPVOLTAGE 3300

OneWire oneWire(ONE_WIRE_BUS);
DallasTemperature sensors(&oneWire);
MQ135 gasSensor(MQ_sensor);
DFRobot_ESP_PH ph;

const int numReadings = 5;
float readings[numReadings];
int readIndex = 0;
float total = 0;
float average = 0;
float temperature;
float voltage;
int currentIndex = 0;

FirebaseData fbdo;
FirebaseAuth auth;
FirebaseConfig config;

unsigned long sendDataPrevMillis = 0;

bool signInOK = false;

// Function declarations
void readTemperature();
void readAirQuality();
void readTDS();
void readPH();
void readTurbidity();

void setup() {
  Serial.begin(9600);
  sensors.begin();
  
  WiFi.begin(WIFI_SSID, WIFI_PASSWORD);
  while (WiFi.status() != WL_CONNECTED) {
    delay(1000);
    Serial.println("Connecting to WiFi..");
  }
  Serial.println("Connected to WiFi");

  config.api_key = API_KEY;
  config.database_url = DATABASE_URL;

  // Autentikasi pengguna Firebase
  if (Firebase.signInWithEmailAndPassword(&config, &auth, "user@gmail.com", "password123")) {
    Serial.println("Sign in successful");
    signInOK = true;
  } else {
    Serial.println("Sign in failed");
  }
  config.token_status_callback = tokenStatusCallback;
  Firebase.begin(&config, &auth);
  Firebase.reconnectWiFi(true);
}

void loop() {
  if (Firebase.ready() && signInOK && (millis() - sendDataPrevMillis > 15000 || sendDataPrevMillis == 0)) {
    sendDataPrevMillis = millis();

    readTemperature();
    readAirQuality();
    readTDS();
    readPH();
    readTurbidity();
    delay(10000);
  }
}

void readTemperature() {
  sensors.requestTemperatures(); // Meminta pembacaan suhu dari sensor
  temperature = sensors.getTempCByIndex(0); // Mendapatkan nilai suhu dari sensor
  temperature = 1.0465 * temperature - 1.3365; // Melakukan kalibrasi Regresi Linear suhu
  Serial.print("Suhu: "); // Output ke Serial Monitor
  Serial.print(temperature); // Output nilai suhu
  Serial.println(" °C"); // Output satuan suhu

  if(Firebase.RTDB.setFloat(&fbdo, "Sensors/Suhu",temperature)){
    Serial.println();Serial.print(temperature);
    Serial.print("- successfully saved to: " + fbdo.dataPath());
    Serial.println(" (" +fbdo.dataType() + ")");
  } else {
    Serial.println("FAILED" +fbdo.errorReason());
  }
}

void readAirQuality() {
  float VRL = analogRead(MQ_sensor) * (3.3 / 4095.0); // Membaca tegangan dari sensor MQ
  float RS = (3.3 / VRL - 1) * 10; // Menghitung resistansi sensor
  float ratio = RS / Ro; // Menghitung rasio Rs/Ro
  float ppm = pow(10, ((log10(ratio) - b) / m)); // Menghitung ppm berdasarkan rasio
  total = total - readings[readIndex]; // Mengupdate total pembacaan
  readings[readIndex] = ppm; // Menyimpan pembacaan ppm ke dalam array
  total = total + readings[readIndex]; // Mengupdate total pembacaan
  readIndex = readIndex + 1; // Mengupdate indeks pembacaan
  if (readIndex >= numReadings) { // Memastikan indeks pembacaan tetap dalam rentang array
    readIndex = 0; // Kembali ke indeks awal jika melebihi jumlah pembacaan
  }
  average = total / numReadings; // Menghitung nilai rata-rata ppm
  Serial.print("Amonia ppm: "); // Output ke Serial Monitor
  Serial.println(average); // Output nilai rata-rata ppm

  if(Firebase.RTDB.setFloat(&fbdo, "Sensors/Amonia",average)){
    Serial.println();Serial.print(average);
    Serial.print("- successfully saved to: " + fbdo.dataPath() + "ppm");
    Serial.println(" (" +fbdo.dataType() + ")");
  } else {
    Serial.println("FAILED" +fbdo.errorReason());
  }
}

void readTDS() {
  int sensorValue = analogRead(TDS_Pin); // Membaca nilai analog dari sensor TDS
  float tdsValue = (0.6656 * sensorValue) + 69.604; // Melakukan kalibrasi nilai TDS
  Serial.print("TDS Value: "); // Output ke Serial Monitor
  Serial.println(sensorValue); // Output nilai TDS

  if(Firebase.RTDB.setFloat(&fbdo, "Sensors/TDS",sensorValue)){
    Serial.println();Serial.print(sensorValue);
    Serial.print("- successfully saved to: " + fbdo.dataPath());
    Serial.println(" (" +fbdo.dataType() + ")");
  } else {
    Serial.println("FAILED" +fbdo.errorReason());
  }
}

void readPH() {
  voltage = analogRead(PH_PIN) / ESPADC * ESPVOLTAGE; // Membaca tegangan dari sensor pH
  float phValue = ph.readPH(voltage, temperature); // Mendapatkan nilai pH dari sensor
  float corrected_pH = (-0.4869 * phValue) + 9.5045; // Koreksi nilai pH
  Serial.print("pH:"); // Output ke Serial Monitor
  Serial.println(phValue, 4); // Output nilai pH

  if(Firebase.RTDB.setFloat(&fbdo, "Sensors/Ph",phValue)){
    Serial.println();Serial.print(phValue);
    Serial.print("- successfully saved to: " + fbdo.dataPath());
    Serial.println(" (" +fbdo.dataType() + ")");
  } else {
    Serial.println("FAILED" +fbdo.errorReason());
  }
}

void readTurbidity() {
  int Turbidity = analogRead(sensorPin); // Membaca nilai dari sensor kekeruhan air
  total = total - readings[currentIndex]; // Mengupdate total pembacaan
  readings[currentIndex] = Turbidity; // Menyimpan pembacaan sensor ke dalam array
  total = total + readings[currentIndex]; // Mengupdate total pembacaan
  currentIndex = (currentIndex + 1) % numReadings; // Pindah ke indeks berikutnya, atur kembali ke 0 jika sudah mencapai batas
  int average = total / numReadings; // Menghitung rata-rata pembacaan sensor
  int kekeruhan = map(average, 0, 700, 100, 0); // Konversi nilai sensor ke nilai kekeruhan dalam rentang 0-100
  Serial.print("Kekeruhan Air : "); // Output ke Serial Monitor
  Serial.println(kekeruhan); // Output nilai kekeruhan air

  if(Firebase.RTDB.setFloat(&fbdo, "Sensors/Turbidity",kekeruhan)){
    Serial.println();Serial.print(kekeruhan);
    Serial.print("- successfully saved to: " + fbdo.dataPath());
    Serial.println(" (" +fbdo.dataType() + ")");
  } else {
    Serial.println("FAILED" +fbdo.errorReason());
  }
}
