#include <WiFi.h>
#include <Firebase_ESP_Client.h>
#include <OneWire.h>
#include <DallasTemperature.h>
#include <MQ135.h>
#include <DFRobot_PH.h>

#include "addons/TokenHelper.h"
#include "addons/RTDBHelper.h"

// WiFi and Firebase configuration
#define WIFI_SSID "Kos34D_Lt2"
#define WIFI_PASSWORD "Eric2010"
#define API_KEY "AIzaSyBN2McacTs5kKbfS2Lc5umzutLqZkHuQso"
#define DATABASE_URL "https://ta-capstone-22597-default-rtdb.asia-southeast1.firebasedatabase.app/"
#define USER_EMAIL "user@gmail.com"
#define USER_PASSWORD "password123"

// Pin definitions
#define ONE_WIRE_BUS 2  // Temperature sensor pin
#define MQ_SENSOR 33    // Ammonia gas sensor pin
#define TDS_PIN 32      // TDS sensor pin
#define PH_PIN 34       // pH sensor pin
#define TURBIDITY_PIN A0 // Turbidity sensor pin

// Relay pins
const int chiller = 16; // Deklarasi dan inisialisasi pin relay
const int Heater = 17; // Deklarasi dan inisialisasi pin relay
const int waterpump = 18; // Deklarasi dan inisialisasi pin relay

// Relay limits
#define MIN_TEMPERATURE 24
#define MAX_TEMPERATURE 28
#define MIN_AMONIA 0
#define MAX_AMONIA 0.2
#define MIN_TDS 0
#define MAX_TDS 100
#define MIN_PH 0
#define MAX_PH 14
#define MIN_TURBIDITY 5
#define MAX_TURBIDITY 37

// Sensor reading parameters
#define RL 10
#define m -0.417
#define b 0.425
#define Ro 13
#define ESPADC 4096.0
#define ESPVOLTAGE 3300

// Initialize sensors
OneWire oneWire(ONE_WIRE_BUS);
DallasTemperature temperatureSensor(&oneWire);
MQ135 gasSensor(MQ_SENSOR);
DFRobot_PH ph;

// deklarasi formulas
const int numReadings = 5; // Jumlah pembacaan untuk perhitungan rata-rata
float readings[numReadings]; // Array untuk menyimpan pembacaan sensor
int readIndex = 0; // Indeks pembacaan saat ini
float total = 0; // Total pembacaan untuk perhitungan rata-rata
float average = 0; // Nilai rata-rata pembacaan

// Sensor values
float temperature;
float Suhu;
float voltage;
float corrected_pH;
float tdsValue;
float Amonia;
float kekeruhan;
//Sensors percentage
float temperaturePercentage;
float amoniaPercentage;
float tdsPercentage;
float phPercentage;
float turbidityPercentage;
//state variables
bool heaterState = false;
bool coolerState = false;
bool waterPumpState = false;

int currentIndex = 0;

// Firebase objects
FirebaseData fbdo;
FirebaseAuth auth;
FirebaseConfig config;
//path declare
String uid;
String databasePathSensors;
String databasePathRelay;
//Sensors path
String tempPath = "/Suhu";
String amoPath = "/Amonia";
String tdsPath = "/Tds";
String phPath = "/ph";
String turbPath = "/turbidity";
//percentage path
String tempPercPath = "/SuhuPercentage";
String amoPercPath = "/AmoniaPercentage";
String tdsPercPath = "/TdsPercentage";
String phPercPath = "/phPercentage";
String turbPercPath = "/turbidityPercentage";
String sensorspath;

FirebaseJson json;


// Timing
unsigned long sendDataPrevMillis = 0;
unsigned long timerDelay = 5000; // 5 seconds delay

// Initialize WiFi connection
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

// Initialize Firebase and authenticate user
void initFirebase() {
  config.api_key = API_KEY;
  config.database_url = DATABASE_URL;
  auth.user.email = USER_EMAIL;
  auth.user.password = USER_PASSWORD;
  config.token_status_callback = tokenStatusCallback;
  config.max_token_generation_retry = 0;
  Firebase.begin(&config, &auth);

  // Wait until user UID is obtained
  Serial.println("Getting User UID");
  while (auth.token.uid == "") {
    Serial.print('.');
    delay(500);
  }
  uid = auth.token.uid.c_str();
  Serial.print("User UID: ");
  Serial.println(uid);

  // Set database paths
  databasePathSensors = "/UsersData/" + uid + "/Sensors";
  databasePathRelay = "/UsersData/" + uid + "/relayState";
}

// Sensor reading functions
void readTemperature(){
  temperatureSensor.requestTemperatures();
  float temperature = temperatureSensor.getTempCByIndex(0);
  Suhu = 1.0465 * temperature - 1.3365;
  // Suhu = map(average, 0, 100, 28, 0);
  Serial.print("Suhu: ");
  Serial.print(Suhu);
  Serial.println(" °C");
  // Calculate percentage
  temperaturePercentage = map(Suhu, MIN_TEMPERATURE, MAX_TEMPERATURE, 0, 100);
  temperaturePercentage = constrain(temperaturePercentage, 0, 100);
  Serial.print("Suhu (Persentase): ");
  Serial.print(temperaturePercentage);
  Serial.println("%");
}

void readAirQuality() {
  float VRL = analogRead(MQ_SENSOR) * (3.3 / 4095.0);
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
  Amonia = map(average, 0, 100, 0.2, 0);
  Serial.print("Amonia ppm: ");
  Serial.println(Amonia);
  // Calculate percentage using the custom mapFloat function
  amoniaPercentage = mapFloat(Amonia, MIN_AMONIA, MAX_AMONIA, 0, 100);
  amoniaPercentage = constrain(amoniaPercentage, 0, 100);
  Serial.print("Amonia (Persentase): ");
  Serial.print(amoniaPercentage);
  Serial.println("%");
}

void readTDS() {
  int sensorValue = analogRead(TDS_PIN);
  average = (0.6656 * sensorValue) + 69.604;
  tdsValue = map(average, 0, 1000, 500, 0);
  Serial.print("TDS Value: ");
  Serial.println(tdsValue);
  // Calculate percentage
  tdsPercentage = map(tdsValue, MIN_TDS, MAX_TDS, 0, 100);
  tdsPercentage = constrain(tdsPercentage, 0, 100);
  Serial.print("TDS (Persentase): ");
  Serial.print(tdsPercentage);
  Serial.println("%");
}
void readPH() {
  voltage = analogRead(PH_PIN) / ESPADC * ESPVOLTAGE;
  float phValue = ph.readPH(voltage, temperature);
  corrected_pH = (-0.4869 * phValue) + 9.5045;
  Serial.print("pH:");
  Serial.println(corrected_pH, 4);
  // Calculate percentage
  phPercentage = map(corrected_pH, MIN_PH, MAX_PH, 0, 100);
  phPercentage = constrain(phPercentage, 0, 100);
  Serial.print("pH (Persentase): ");
  Serial.print(phPercentage);
  Serial.println("%");
}

void readTurbidity() {
  int Turbidity = analogRead(TURBIDITY_PIN);
  total = total - readings[currentIndex];
  readings[currentIndex] = Turbidity;
  total = total + readings[currentIndex];
  currentIndex = (currentIndex + 1) % numReadings;
  average = total / numReadings;
  kekeruhan = map(average, 0, 700, 37, 0);
  Serial.print("Kekeruhan Air : ");
  Serial.println(kekeruhan);
  // Calculate percentage
  turbidityPercentage = map(kekeruhan, MIN_TURBIDITY, MAX_TURBIDITY, 0, 100);
  turbidityPercentage = constrain(turbidityPercentage, 0, 100);
  Serial.print("Kekeruhan Air (Persentase): ");
  Serial.print(turbidityPercentage);
  Serial.println("%");
} 

// Custom mapping function for float values
float mapFloat(float x, float in_min, float in_max, float out_min, float out_max) {
  return (x - in_min) * (out_max - out_min) / (in_max - in_min) + out_min;
}

// Control relays based on sensor values
void controlRelays() {
  if (Suhu > MAX_TEMPERATURE) {
    digitalWrite(chiller, HIGH);
    coolerState = true;
  } else {
    digitalWrite(chiller, LOW);
    coolerState = false;
  }

  if (Suhu < MIN_TEMPERATURE) {
    digitalWrite(Heater, HIGH);
    heaterState = true;
  } else {
    digitalWrite(Heater, LOW);
    heaterState = false;
  }

  if (tdsValue > MAX_TDS) {
    digitalWrite(waterpump, HIGH);
    waterPumpState = true;
  } else {
    digitalWrite(waterpump, LOW);
    waterPumpState = false;
  }
}

// Update relay states in Firebase
void updateRelayStates() {
  json.clear();
  json.set("chiller", coolerState ? "1" : "0");
  json.set("heater", heaterState ? "1" : "0");
  json.set("waterpump", waterPumpState ? "1" : "0");

  String relayJsonData;
  json.toString(relayJsonData); // Convert JSON object to string
  Serial.println("Relay JSON Data: " + relayJsonData); // Print JSON data for debugging
  Serial.println("Database Path Relay: " + databasePathRelay); // Print database path for debugging
  Serial.printf("Set JSON... %s\n", Firebase.RTDB.setJSON(&fbdo, databasePathRelay.c_str(), &json) ? "ok" : fbdo.errorReason().c_str());
}

// Setup function
void setup() {
  Serial.begin(115200);
  temperatureSensor.begin();

  pinMode(chiller, OUTPUT);
  pinMode(Heater, OUTPUT);
  pinMode(waterpump, OUTPUT);

  initWiFi();
  initFirebase();
}

// Main loop
void loop() {
  readTemperature();
  delay(2000); // Add delay to reduce the load
  readAirQuality();
  delay(2000); // Add delay to reduce the load
  readTDS();
  delay(2000); // Add delay to reduce the load
  readPH();
  delay(2000); // Add delay to reduce the load
  readTurbidity();
  delay(2000); // Add delay to reduce the load
  controlRelays();

  if (Firebase.ready() && (millis() - sendDataPrevMillis > timerDelay || sendDataPrevMillis == 0)) {
    sendDataPrevMillis = millis();

    sensorspath = databasePathSensors + "/";

    json.set(tempPath.c_str(), String(Suhu)); // Assuming temperature is a float or int
    json.set(tempPercPath.c_str(), String(temperaturePercentage));
    json.set(amoPath.c_str(), String(Amonia)); // Assuming average is a float or int
    json.set(amoPercPath.c_str(), String(amoniaPercentage));
    json.set(tdsPath.c_str(), String(tdsValue)); // Assuming sensorValue is an int or float
    json.set(tdsPercPath.c_str(), String(tdsPercentage));
    json.set(phPath.c_str(), String(corrected_pH)); // Assuming phValue is a float
    json.set(phPercPath.c_str(), String(phPercentage));
    json.set(turbPath.c_str(), String(kekeruhan)); // Assuming kekeruhan is an int
    json.set(turbPercPath.c_str(), String(turbidityPercentage));

    String jsonData;
    json.toString(jsonData); // Convert JSON object to string
    Serial.println("JSON Data: " + jsonData); // Print JSON data for debugging
    
    Serial.printf("Set json... %s\n", Firebase.RTDB.setJSON(&fbdo, sensorspath.c_str(), &json) ? "ok" : fbdo.errorReason().c_str());
    // Update relay states
    updateRelayStates();

    delay(1000); // Increased delay to reduce load
  }

}
