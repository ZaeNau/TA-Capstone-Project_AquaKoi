#if defined(ESP32)
  #include <WiFi.h>
#endif
#include <Firebase_ESP_Client.h>
#include <OneWire.h>
#include <DallasTemperature.h>
#include <MQ135.h>

#define WIFI_SSID "Kos34D_Lt2_plus"
#define WIFI_PASSWORD "Eric2010"

//TOKEN GEN
#include "addons/TokenHelper.h"
//PAYLOAD real-time database
#include "addons/RTDBHelper.h"

// Sensor pins
#define ONE_WIRE_BUS 2
#define MQ135_Pin 35

OneWire oneWire(ONE_WIRE_BUS);
DallasTemperature sensors(&oneWire);
MQ135 gasSensor(MQ135_Pin);

// Insert Firebase project API Key
#define API_KEY "AIzaSyBN2McacTs5kKbfS2Lc5umzutLqZkHuQso"

#define DATABASE_URL "https://ta-capstone-22597-default-rtdb.asia-southeast1.firebasedatabase.app/" 

// Define Firebase Data object.
FirebaseData fbdo;
// Define firebase authentication.
FirebaseAuth auth;
// Define firebase configuration.
FirebaseConfig config;

// Timing variables for sending and reading data from Firebase
unsigned long sendDataPrevMillis = 0;
const long sendDataIntervalMillis = 2000; // 2 seconds

unsigned long readDataPrevMillis = 0;
const long readDataIntervalMillis = 10000; // 10 seconds

// Boolean variable for sign in status.
bool signupOK = false;

void setup() {
  Serial.begin(115200);
  Serial.println();

  // The process of connecting the WiFi on the ESP32 to the WiFi.
  WiFi.mode(WIFI_STA);
  WiFi.begin(WIFI_SSID, WIFI_PASSWORD);
  Serial.println("---------------Connection");
  Serial.print("Connecting to : ");
  Serial.println(WIFI_SSID);
  while (WiFi.status() != WL_CONNECTED){
    Serial.print(".");
    delay(500);
  }
  Serial.println();
  Serial.print("Successfully connected to : ");
  Serial.println(WIFI_SSID);
  Serial.println("---------------");

  // CONFIGURATION the api key (required).
  config.api_key = API_KEY;

  // CONFIGURATION the RTDB URL (required).
  config.database_url = DATABASE_URL;

  // Sign up.
  Serial.println();
  Serial.println("---------------Sign up");
  Serial.print("Sign up new user... ");
  if (Firebase.signUp(&config, &auth, "", "")){
    Serial.println("ok");
    signupOK = true;
  }
  else{
    Serial.printf("%s\n", config.signer.signupError.message.c_str());
  }
  Serial.println("---------------");
  
  // CONFIGURATION the callback function for the long running token generation task (RECONNECT WIFI).
  config.token_status_callback = tokenStatusCallback; //--> see addons/TokenHelper.h
  
  Firebase.begin(&config, &auth);
  Firebase.reconnectWiFi(true);

  sensors.begin();
}

void sendTemperatureData() {
  sensors.requestTemperatures();
  float temperature = sensors.getTempCByIndex(0);
  Serial.print("Temperature: ");
  Serial.println(temperature);

  if (Firebase.RTDB.setFloat(&fbdo, "Sensors/Temperature", temperature)) {
    Serial.println("Temperature data sent to Firebase");
  } else {
    Serial.println("Failed to send temperature data");
    Serial.println("REASON: " + fbdo.errorReason());
  }
}

void sendGasAmoniaData() {
  int gasQuality = analogRead(MQ135_Pin);
  float ppm = gasQuality * (5.0 / 1023.0); 
  Serial.print("Gas Amonia (ppm): ");
  Serial.println(ppm);

  if (Firebase.RTDB.setFloat(&fbdo, "Sensors/GasAmonia", ppm)) {
    Serial.println("Gas ammonia data sent to Firebase");
  } else {
    Serial.println("Failed to send gas ammonia data");
    Serial.println("REASON: " + fbdo.errorReason());

    Serial.println("---------------");
  }
}

void readTemperatureData() {
  if (Firebase.RTDB.getFloat(&fbdo, "Sensors/Temperature")) {
    Serial.print("Read Temperature: ");
    Serial.println(fbdo.floatData());
  } else {
    Serial.println("Failed to read temperature data");
    Serial.println("REASON: " + fbdo.errorReason());
  }
}

void readGasAmoniaData() {
  if (Firebase.RTDB.getFloat(&fbdo, "Sensors/GasAmonia")) {
    Serial.print("Read Gas Amonia (ppm): ");
    Serial.println(fbdo.floatData());
  } else {
    Serial.println("Failed to read gas ammonia data");
    Serial.println("REASON: " + fbdo.errorReason());
  }
}

void loop() {
  // Sending data to Firebase
  if (Firebase.ready() && signupOK && (millis() - sendDataPrevMillis > sendDataIntervalMillis || sendDataPrevMillis == 0)) {
    sendDataPrevMillis = millis();
    sendTemperatureData();
    sendGasAmoniaData();
  }
  
  // Reading data from Firebase
  if (Firebase.ready() && (millis() - readDataPrevMillis > readDataIntervalMillis || readDataPrevMillis == 0)) {
    readDataPrevMillis = millis();
    readTemperatureData();
    readGasAmoniaData();
  }
}