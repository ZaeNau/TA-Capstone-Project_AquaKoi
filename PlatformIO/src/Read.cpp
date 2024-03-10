#if defined(ESP32)
  #include <WiFi.h>
#endif
#include <Firebase_ESP_Client.h>

#define WIFI_SSID "Kos34D_Lt2_plus"
#define WIFI_PASSWORD "Eric2010"

// Insert Firebase project API Key
#define API_KEY "AIzaSyBN2McacTs5kKbfS2Lc5umzutLqZkHuQso"
#define DATABASE_URL "https://ta-capstone-22597-default-rtdb.asia-southeast1.firebasedatabase.app/"

// Define Firebase Data object.
FirebaseData fbdo;
// Define firebase authentication.
FirebaseAuth auth;
// Define firebase configuration.
FirebaseConfig config;

// jarak waktu data variable to send/store data ke firebase database.
unsigned long readDataPrevMillis = 0;
const long readDataIntervalMillis = 10000; // 10 seconds

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
  
  Firebase.begin(&config, &auth);
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
  if (Firebase.ready() && (millis() - readDataPrevMillis > readDataIntervalMillis || readDataPrevMillis == 0)) {
    readDataPrevMillis = millis();
    readTemperatureData();
    readGasAmoniaData();
  }
}
