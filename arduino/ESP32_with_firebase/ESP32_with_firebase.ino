#include <WiFi.h>
#include <Firebase_ESP_Client.h>
#include <OneWire.h>
#include <DallasTemperature.h>
#include <MQ135.h>
#include <DFRobot_PH.h>

#include "addons/TokenHelper.h"
#include "addons/RTDBHelper.h"

#define WIFI_SSID "Kos34D_Lt2"
#define WIFI_PASSWORD "Eric2010"

#define API_KEY "AIzaSyBN2McacTs5kKbfS2Lc5umzutLqZkHuQso"
#define DATABASE_URL "https://ta-capstone-22597-default-rtdb.asia-southeast1.firebasedatabase.app/"

#define USER_EMAIL "user@gmail.com"
#define USER_PASSWORD "password123"

#define ONE_WIRE_BUS 2  // Pin untuk sensor Suhu
#define MQ_sensor 33    // Pin untuk sensor Gas Amonis
#define TDS_Pin 32      // Pin untuk sensor TDS
#define PH_PIN 34       // Pin untuk sensor PH
#define sensorPin A0    // Pin untuk sensor kekeruhan

const int chiller = 16; // Deklarasi dan inisialisasi pin relay
const int Heater = 17; // Deklarasi dan inisialisasi pin relay
const int waterpump = 18; // Deklarasi dan inisialisasi pin relay

#define RL 10
#define m -0.417
#define b 0.425
#define Ro 13
#define ESPADC 4096.0
#define ESPVOLTAGE 3300

#define MIN_TEMPERATURE 20
#define MAX_TEMPERATURE 28
#define MIN_AMONIA 0 // Ubah nilainya sesuai rentang yang diharapkan
#define MAX_AMONIA 0.2 // Ubah nilainya sesuai rentang yang diharapkan
#define MIN_TDS 0 // Ubah nilainya sesuai rentang yang diharapkan
#define MAX_TDS 100 // Ubah nilainya sesuai rentang yang diharapkan
#define MIN_PH 0 // Ubah nilainya sesuai rentang yang diharapkan
#define MAX_PH 14 // Ubah nilainya sesuai rentang yang diharapkan
#define MIN_TURBIDITY 0 // Ubah nilainya sesuai rentang yang diharapkan
#define MAX_TURBIDITY 37 // Ubah nilainya sesuai rentang yang diharapkan

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

float temperaturePercentage;
float amoniaPercentage;
float tdsPercentage;
float phPercentage;
float turbidityPercentage;

int currentIndex = 0;

FirebaseData fbdo;
FirebaseAuth auth;
FirebaseConfig config;
String uid;
String databasePath;

String tempPath = "/Suhu";
String amoPath = "/Amonia";
String tdsPath = "/Tds";
String phPath = "/ph";
String turbPath = "/turbidity";
String tempPercPath = "/SuhuPercentage";
String amoPercPath = "/AmoniaPercentage";
String tdsPercPath = "/TdsPercentage";
String phPercPath = "/phPercentage";
String turbPercPath = "/turbidityPercentage";
String parentPath;

FirebaseJson json;

unsigned long sendDataPrevMillis = 0;
unsigned long timerDelay = 5000; // Increased delay to 60 seconds

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
void controlRelays();

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
  readTemperature();
  delay(2000);
  readAirQuality();
  delay(2000);
  readTDS();
  delay(2000);
  readPH();
  delay(2000);
  readTurbidity();
  delay(2000);
  controlRelays();
  updateRelayStates();
  
  if (Firebase.ready() && (millis() - sendDataPrevMillis > timerDelay || sendDataPrevMillis == 0)) {
    sendDataPrevMillis = millis();
    String sensorPath = databasePath + "/Sensors/";

    json.set("/Suhu", String(temperature));
    json.set("/SuhuPercentage", String(temperaturePercentage));
    json.set("/Amonia", String(Amonia));
    json.set("/AmoniaPercentage", String(amoniaPercentage));
    json.set("/Tds", String(tdsValue));
    json.set("/TdsPercentage", String(tdsPercentage));
    json.set("/ph", String(corrected_pH));
    json.set("/phPercentage", String(phPercentage));
    json.set("/turbidity", String(kekeruhan));
    json.set("/turbidityPercentage", String(turbidityPercentage));

    String jsonData;
    json.toString(jsonData);
    Serial.println("JSON Data: " + jsonData);

    Serial.printf("Set json... %s\n", Firebase.RTDB.setJSON(&fbdo, sensorPath.c_str(), &json) ? "ok" : fbdo.errorReason().c_str());
    
    delay(1000);
  }
}

void updateRelayStates() {
  if (Firebase.ready() && (millis() - sendDataPrevMillis > timerDelay || sendDataPrevMillis == 0)) {
    sendDataPrevMillis = millis();
    String relayPath = databasePath + "/relayState/";

    json.set("chiller", digitalRead(chiller) == HIGH ? "1" : "0");
    json.set("heater", digitalRead(Heater) == HIGH ? "1" : "0");
    json.set("waterpump", digitalRead(waterpump) == HIGH ? "1" : "0");

    String jsonData;
    json.toString(jsonData);
    Serial.println("JSON Data: " + jsonData);

    Serial.printf("Set json... %s\n", Firebase.RTDB.setJSON(&fbdo, relayPath.c_str(), &json) ? "ok" : fbdo.errorReason().c_str());

    delay(1000);
  }
}

void controlRelays() {
  if (Suhu > MAX_TEMPERATURE) {
    digitalWrite(chiller, HIGH);
    Serial.println("Chiller ON");
  } else if (Suhu < MIN_TEMPERATURE) {
    digitalWrite(Heater, HIGH);
    Serial.println("Heater ON");
  } else {
    digitalWrite(chiller, LOW);
    digitalWrite(Heater, LOW);
    Serial.println("Chiller OFF");
    Serial.println("Heater OFF");
  }

  if (tdsValue > MAX_TDS) {
    digitalWrite(waterpump, HIGH);
    Serial.println("Water Pump ON");
  } else {
    digitalWrite(waterpump, LOW);
    Serial.println("Water Pump OFF");
  }
}

void readTemperature(){
  sensors.requestTemperatures();
  float temperature = sensors.getTempCByIndex(0);
  Suhu = 1.0465 * temperature - 1.3365;
  Serial.print("Suhu: ");
  Serial.print(Suhu);
  Serial.println(" °C");
  // Calculate percentage
  temperaturePercentage = map(Suhu, MIN_TEMPERATURE, MAX_TEMPERATURE, 0, 100);
  Serial.print("Suhu (Persentase): ");
  Serial.print(temperaturePercentage);
  Serial.println("%");
}

// Custom mapping function for float values
float mapFloat(float x, float in_min, float in_max, float out_min, float out_max) {
  return (x - in_min) * (out_max - out_min) / (in_max - in_min) + out_min;
}

void readAirQuality() {
  float VRL = analogRead(MQ_sensor) * (3.3 / 4095.0);
  float RS = (3.3 / VRL - 1) * 10;
  float ratio = RS / Ro;
  float ppm = pow(10, ((log10(ratio) - b) / m));
  total = total - readings[readIndex];
  readings[readIndex] = ppm;
  total = total + readings[readIndex];
  readIndex = readIndex + 1;
  if (readIndex >= numReadings) {
    readIndex = 0;
  }
  average = total / numReadings;
  Amonia = map(average, 0, 10, 0.2, 0);
  Serial.print("Amonia ppm: ");
  Serial.println(Amonia);
  // Calculate percentage using the custom mapFloat function
  amoniaPercentage = mapFloat(Amonia, MIN_AMONIA, MAX_AMONIA, 0, 100);
  Serial.print("Amonia (Persentase): ");
  Serial.print(amoniaPercentage);
  Serial.println("%");
}

void readTDS(){
  int sensorValue = analogRead(TDS_Pin);
  average = (0.6656 * sensorValue) + 69.604;
  tdsValue = map(average, 0, 1000, 500, 0);
  Serial.print("TDS Value: ");
  Serial.println(tdsValue);
  // Calculate percentage
  tdsPercentage = map(tdsValue, MIN_TDS, MAX_TDS, 0, 100);
  Serial.print("TDS (Persentase): ");
  Serial.print(tdsPercentage);
  Serial.println("%");
}

void readPH(){
  voltage = analogRead(PH_PIN) / ESPADC * ESPVOLTAGE;
  float phValue = ph.readPH(voltage, temperature);
  corrected_pH = (-0.4869 * phValue) + 9.5045;
  Serial.print("pH:");
  Serial.println(corrected_pH, 4);
  // Calculate percentage
  phPercentage = map(corrected_pH, MIN_PH, MAX_PH, 0, 100);
  Serial.print("pH (Persentase): ");
  Serial.print(phPercentage);
  Serial.println("%");
}

void readTurbidity(){
  int Turbidity = analogRead(sensorPin);
  total = total - readings[currentIndex];
  readings[currentIndex] = Turbidity;
  total = total + readings[currentIndex];
  currentIndex = (currentIndex + 1) % numReadings;
  int average = total / numReadings;
  kekeruhan = map(average, 0, 700, 37, 0);
  Serial.print("Kekeruhan Air : ");
  Serial.println(kekeruhan);
  // Calculate percentage
  turbidityPercentage = map(kekeruhan, MIN_TURBIDITY, MAX_TURBIDITY, 0, 100);
  Serial.print("Kekeruhan Air (Persentase): ");
  Serial.print(turbidityPercentage);
  Serial.println("%");
} 
