#include <WiFi.h>
#include <Firebase_ESP_Client.h>
#include <OneWire.h>
#include <DallasTemperature.h>
#include <MQ135.h>
#include <DFRobot_PH.h>

#include "addons/TokenHelper.h"
#include "addons/RTDBHelper.h"

#define WIFI_SSID "P0C0 F4"
#define WIFI_PASSWORD "123nau123"

#define API_KEY "AIzaSyBN2McacTs5kKbfS2Lc5umzutLqZkHuQso"
#define DATABASE_URL "https://ta-capstone-22597-default-rtdb.asia-southeast1.firebasedatabase.app/"

#define USER_EMAIL "user@gmail.com"
#define USER_PASSWORD "password123"

#define ONE_WIRE_BUS 2  // Pin untuk sensor Temparture
#define MQ_sensor 33    // Pin untuk sensor Gas Amonis
#define TDS_Pin 32      // Pin untuk sensor TDS
#define PH_PIN 34       // Pin untuk sensor PH
#define sensorPin A0    // Pin untuk sensor kekeruhan

const int Heater = 5; // Deklarasi dan inisialisasi pin relay
const int chiller = 4; // Deklarasi dan inisialisasi pin relay
const int waterpump = 18; // Deklarasi dan inisialisasi pin relay

#define RL 10
#define m -0.417
#define b 0.425
#define Ro 13
#define ESPADC 4096.0
#define ESPVOLTAGE 3300

// Inisialisasi Sensor untuk pembacaan
OneWire oneWire(ONE_WIRE_BUS);
DallasTemperature sensors(&oneWire);
MQ135 gasSensor(MQ_sensor);
DFRobot_PH ph;

const int numReadings = 5; // Jumlah pembacaan untuk perhitungan rata-rata
float readings[numReadings]; // Array untuk menyimpan pembacaan sensor
int readIndex = 0; // Indeks pembacaan saat ini
float total = 0; // Total pembacaan untuk perhitungan rata-rata
float average = 0; // Nilai rata-rata pembacaan

float temperature;
float Suhu;
float voltage;
float corrected_pH;
float tdsValue;
float Amonia;
float kekeruhan;

int currentIndex = 0;

FirebaseData fbdo;
FirebaseAuth auth;
FirebaseConfig config;
String uid;
String databasePath;

String tempPath = "/Suhu";
String coolPath = "/Cooler";
String heatPath = "/Heater";
String amoPath = "/Amonia";
String tdsPath = "/Tds";
String pumpPath = "/Pump";
String phPath = "/ph";
String turbPath = "/turbidity";
String parentPath;

FirebaseJson json;

unsigned long sendDataPrevMillis = 0;
unsigned long timerDelay = 5000;

bool signInOK = false;

// Initialize WiFi
void initWiFi() {
  WiFi.begin(WIFI_SSID, WIFI_PASSWORD);
  Serial.print("Connecting to WiFi ..");
  while (WiFi.status() != WL_CONNECTED) {
    Serial.print('.');
    delay(500);
  }
  Serial.println(WiFi.localIP());
  Serial.println();
}

// Function declarations
void readTemperature();
void readAirQuality();
void readTDS();
void readPH();
void readTurbidity();

void setup() {
  Serial.begin(115200);
  sensors.begin();

  pinMode(Heater, OUTPUT); // Set pin relay sebagai output
  pinMode(chiller, OUTPUT); // Set pin chiller sebagai output
  pinMode(waterpump, OUTPUT); // Set pin chiller sebagai output
  
  initWiFi();
  config.api_key = API_KEY;
  config.database_url = DATABASE_URL;
  auth.user.email = USER_EMAIL;
  auth.user.password = USER_PASSWORD;
  // Assign the callback function for the long running token generation task
  config.token_status_callback = tokenStatusCallback; //see addons/TokenHelper.h
  // Assign the maximum retry of token generation
  config.max_token_generation_retry = 0;
  // Initialize the library with the Firebase authen and config
  Firebase.begin(&config, &auth);
  // Getting the user UID might take a few seconds
  Serial.println("Getting User UID");
  while ((auth.token.uid) == "") {
  Serial.print('.');
  delay(500);
  }
  uid = auth.token.uid.c_str();
  Serial.print("User UID: ");
  Serial.print(uid);
  // Update database path
  databasePath = "/UsersData/" + uid + "/Sensors";
}

void loop() {
  if (Firebase.ready() && (millis() - sendDataPrevMillis > timerDelay || sendDataPrevMillis == 0)) {
    sendDataPrevMillis = millis();
    parentPath = databasePath + "/";
    
    readTemperature();
    json.set(tempPath.c_str(), String(Suhu)); // Assuming temperature is a float or int
    json.set(coolPath.c_str(), String(chiller));
    json.set(heatPath.c_str(), String(Heater));
    readAirQuality();
    json.set(amoPath.c_str(), String(Amonia)); // Assuming average is a float or int
    readTDS();
    json.set(tdsPath.c_str(), String(tdsValue)); // Assuming sensorValue is an int or float
    json.set(pumpPath.c_str(), String(waterpump));
    readPH();
    json.set(phPath.c_str(), String(corrected_pH)); // Assuming phValue is a float
    readTurbidity();
    json.set(turbPath.c_str(), String(kekeruhan)); // Assuming kekeruhan is an int

    String jsonData;
    json.toString(jsonData); // Convert JSON object to string
    Serial.println("JSON Data: " + jsonData); // Print JSON data for debugging
    
    Serial.printf("Set json... %s\n", Firebase.RTDB.setJSON(&fbdo, parentPath.c_str(), &json) ? "ok" : fbdo.errorReason().c_str());
    
    delay(500);
  }
}


void readTemperature(){
  sensors.requestTemperatures(); // Meminta pembacaan suhu dari sensor
  float temperature = sensors.getTempCByIndex(0); // Mendapatkan nilai suhu dari sensor
  Suhu = 1.0465 * temperature - 1.3365; // Melakukan kalibrasi Regresi Linear suhu
  Serial.print("Suhu: "); // Output ke Serial Monitor
  Serial.print(Suhu); // Output nilai suhu
  Serial.println(" °C"); // Output satuan suhu
     if (Suhu > 28.00) {
    digitalWrite(chiller, HIGH); // Nyalakan chiller
    Serial.println("ON ");
  } else if (Suhu < 20.00) {
    digitalWrite(Heater, HIGH); // Nyalakan heater
    Serial.println("ON ");
  } else {
    digitalWrite(chiller, LOW); // Matikan chiller
    digitalWrite(Heater, LOW); // Matikan heater
    Serial.println("Chiller OFF");
    Serial.println("Heater OFF");
  }
}

void readAirQuality(){
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
  Amonia = total / numReadings; // Menghitung nilai rata-rata ppm
  Serial.print("Amonia ppm: "); // Output ke Serial Monitor
  Serial.println(Amonia); // Output nilai rata-rata ppm
}

void readTDS(){
  int sensorValue = analogRead(TDS_Pin); // Membaca nilai analog dari sensor TDS
  tdsValue = (0.6656 * sensorValue) + 69.604; // Melakukan kalibrasi nilai TDS
  Serial.print("TDS Value: "); // Output ke Serial Monitor
  Serial.println(tdsValue); // Output nilai TDS
      if (tdsValue > 150) {
    digitalWrite(waterpump, HIGH); // Nyalakan chiller
    Serial.println("ON ");
  } else {
    digitalWrite(waterpump, LOW); // Matikan chiller
    Serial.println("OFF");
  }
}

void readPH(){
  voltage = analogRead(PH_PIN) / ESPADC * ESPVOLTAGE; // Membaca tegangan dari sensor pH
  float phValue = ph.readPH(voltage, temperature); // Mendapatkan nilai pH dari sensor
  corrected_pH = (-0.4869 * phValue) + 9.5045; // Koreksi nilai pH
  Serial.print("pH:"); // Output ke Serial Monitor
  Serial.println(corrected_pH, 4); // Output nilai pH
}

void readTurbidity(){
  int Turbidity = analogRead(sensorPin); // Membaca nilai dari sensor kekeruhan air
  total = total - readings[currentIndex]; // Mengupdate total pembacaan
  readings[currentIndex] = Turbidity; // Menyimpan pembacaan sensor ke dalam array
  total = total + readings[currentIndex]; // Mengupdate total pembacaan
  currentIndex = (currentIndex + 1) % numReadings; // Pindah ke indeks berikutnya, atur kembali ke 0 jika sudah mencapai batas
  int average = total / numReadings; // Menghitung rata-rata pembacaan sensor
  kekeruhan = map(average, 0, 700, 100, 0); // Konversi nilai sensor ke nilai kekeruhan dalam rentang 0-100
  Serial.print("Kekeruhan Air : "); // Output ke Serial Monitor
  Serial.println(kekeruhan); // Output nilai kekeruhan air
}