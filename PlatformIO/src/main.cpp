#include <WiFi.h>
#include <Firebase_ESP_Client.h>
#include "WiFiSetup.cpp"
#include "FirebaseSetup.cpp"
#include "DataSender.cpp"
#include "DataReader.cpp"

FirebaseData fbdo;
FirebaseAuth auth;
FirebaseConfig config;

void setup() {
  Serial.begin(115200);
  Serial.println();

  setupWiFi();
  setupFirebase(fbdo, auth, config);
  
  sensors.begin();
}

void loop() {
  // Sending data to Firebase
  sendTemperatureData();
  sendGasAmoniaData();
  
  // Reading data from Firebase
  readTemperatureData();
  readGasAmoniaData();
  
  delay(2000); // Adjust delay as needed
}
