#if defined(ESP32)
  #include <WiFi.h>
#elif defined(ESP8266)
  #include <ESP8266WiFi.h>
#endif
#include <Firebase_ESP_Client.h>
#include <OneWire.h>
#include <DallasTemperature.h>
#include <MQ135.h>
#include <DFRobot_PH.h>


#define WIFI_SSID "Kos34D_Lt2_plus"
#define WIFI_PASSWORD "Eric2010"

//TOKEN GEN
#include "addons/TokenHelper.h"
//PAYLOAD real-time database
#include "addons/RTDBHelper.h"

// Sensor pins
#define ONE_WIRE_BUS 2 // Pin analog untuk sensor Temperature
#define MQ135_Pin 35 // Pin analog untuk sensor MQ135
#define TDS_Pin 34  // Pin analog untuk sensor TDS
#define PH_SENSOR_PIN 32 // // Pin analog untuk sensor PH

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
// Definee firebase configuration.
FirebaseConfig config;

// jarak waktu data variable to send/store data ke firebase database.
unsigned long sendDataPrevMillis = 0;
const long sendDataIntervalMillis = 1000; //=> 1 detik 

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

void loop() {
  // put your main code here, to run repeatedly:
  if (Firebase.ready() && signupOK && (millis() - sendDataPrevMillis > sendDataIntervalMillis || sendDataPrevMillis == 0)){
    sendDataPrevMillis = millis();

    sendTemperatureData();
    sendGasAmoniaData();
    sendTDSData();
    sendPHData();
  }
}

void sendTemperatureData() {
  sensors.requestTemperatures();
  float temperature = sensors.getTempCByIndex(0);
  Serial.print("Temperature: ");
  Serial.println(temperature);

  // Kalibrasi suhu 
  temperature = 1.0465 * temperature - 1.3365;

  if (Firebase.RTDB.setFloat(&fbdo, "Sensors/Temperature", temperature)) {
    Serial.println("Temperature data sent to Firebase");
  } else {
    Serial.println("Failed to send temperature data");
    Serial.println("REASON: " + fbdo.errorReason());
  }
}

void sendTDSData() {
  int sensorValue = analogRead(TDS_Pin); // Membaca nilai sensor TDS
  Serial.print("TDS Value: ");
  Serial.println(sensorValue);

  // kalibrasi TDS
  float tdsValue = 0.2977 * sensorValue + 108.97;

  // Mengirimkan nilai TDS yang sudah dikalibrasi ke Firebase
  if (Firebase.RTDB.setFloat(&fbdo, "Sensors/TDS", tdsValue)) {
    Serial.println("TDS data sent to Firebase");
  } else {
    Serial.println("Failed to send TDS data");
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
  }
}

void sendPHData() {
  float pHValue = readPHValue();
  Serial.print("pH Value: ");
  Serial.println(pHValue);
  
  // Kirim nilai pH ke Firebase
  if (Firebase.RTDB.setFloat(&fbdo, "Sensors/pH", pHValue)) {
    Serial.println("pH data sent to Firebase");
  } else {
    Serial.println("Failed to send pH data");
    Serial.println("REASON: " + fbdo.errorReason());
  }
}

float readPHValue() {
  // Baca nilai analog dari sensor pH
  int sensorValue = analogRead(PH_SENSOR_PIN);
  
  // Konversi nilai analog menjadi nilai pH
  // Sesuaikan dengan karakteristik sensor pH Anda
  float pH = map(sensorValue, 0, 1023, 0, 14); // Misalnya, konversi linier dari nilai analog ke pH (0-14)
  
  return pH;
}
