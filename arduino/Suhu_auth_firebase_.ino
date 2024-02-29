#include <WiFi.h>
#include <FirebaseESP32.h>
#include <OneWire.h>
#include <DallasTemperature.h>
#include <MQ135.h>

// WiFi credentials
const char* ssid = "wifi name";
const char* password = "pass word wifi";

// Firebase project details
#define DATABASE_URL "ta-capstone-22597-default-rtdb.asia-southeast1.firebasedatabase.app"
#define API_KEY "AIzaSyBN2McacTs5kKbfS2Lc5umzutLqZkHuQso"

// Sensor pins
#define ONE_WIRE_BUS 2
#define MQ135_Pin 4

OneWire oneWire(ONE_WIRE_BUS);
DallasTemperature sensors(&oneWire);
MQ135 gasSensor(MQ135_Pin);

FirebaseConfig firebaseConfig;
FirebaseAuth firebaseAuth;
FirebaseData firebaseData;

void setup() {
  Serial.begin(9600);
  WiFi.begin(ssid, password);
  if (WiFi.status() == WL_CONNECTED) {
      Serial.println("Connected to WiFi");
  } else {
      Serial.println("WiFi connection failed");
  }

  Serial.println("Connected with IP: " + WiFi.localIP().toString());

  // Configure Firebase
  firebaseConfig.api_key = API_KEY;
  firebaseConfig.database_url = DATABASE_URL;

  Firebase.begin(&firebaseConfig, &firebaseAuth);

  sensors.begin();
}

void loop() {
  sensors.requestTemperatures();
  float temperatureC = sensors.getTempCByIndex(0);
  
  if (temperatureC != DEVICE_DISCONNECTED_C) {
    if (Firebase.setFloat(firebaseData, "/Temperature", temperatureC)) { // Check if Firebase transaction succeeded
      Serial.print("Suhu: ");
      Serial.print(temperatureC);
      Serial.println(" °C");
    } else {
      // Handle Firebase transaction error
      Serial.println("Failed to update temperature to Firebase");
      Serial.println("Reason: "+ firebaseData.errorReason());
    }
  } else {
    Serial.println("Error: Tidak dapat membaca suhu!");
  }

  float air_quality = gasSensor.getPPM(); // Baca kualitas udara dari sensor MQ135
  
  // Membandingkan nilai dengan parameter 0.2 M/L
  if (air_quality < 7.5) {
    Firebase.setString(firebaseData, "/Environment/AirQuality/Status", "Good"); // update value string kualitas udara di firebase 
    Serial.println("Kualitas udara baik.");
  } else {
    Firebase.setString(firebaseData, "/Environment/AirQuality/Status", "Bad");
    Serial.println("Kualitas udara buruk! Perlu perhatian lebih lanjut.");
  }
    if (Firebase.setFloat(firebaseData, "/Environment/AirQuality/PPM", air_quality)) {
        Serial.print("Kualiatas udara (PPM): ");
        Serial.println(air_quality);
    } else {
        Serial.println("Failed to update air quality PPM to Firebase");
        Serial.println("Reason: " + firebaseData.errorReason());
    }

  delay(2000); // Tunggu 2 detik sebelum membaca nilai sensor lagi
}
