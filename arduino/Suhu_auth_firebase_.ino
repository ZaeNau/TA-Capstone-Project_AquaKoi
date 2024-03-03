#include <WiFi.h>
#include <FirebaseESP32.h>
#include <OneWire.h>
#include <DallasTemperature.h>
#include <MQ135.h>

// WiFi credentials
const char* ssid = "Kos34D_Lt2_plus";
const char* password = "Eric2010";

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
  
  // Connect to WiFi
  Serial.println("Connecting to WiFi...");
  WiFi.begin(ssid, password);
  while (WiFi.status() != WL_CONNECTED) {
    delay(500);
    Serial.print(".");
  }
  Serial.println("");
  Serial.println("WiFi connected!");

  // Print local IP address
  Serial.println("IP Address:");
  Serial.println(WiFi.localIP());

  // Configure Firebase
  firebaseConfig.api_key = API_KEY;
  firebaseConfig.database_url = DATABASE_URL;

  Serial.println("Initializing Firebase...");
  Firebase.begin(&firebaseConfig, &firebaseAuth); // Memanggil fungsi Firebase.begin() tanpa menyimpan hasilnya dalam variabel

  // Cek koneksi Firebase
  if (Firebase.ready()) {
    Serial.println("Firebase initialized successfully");
  } else {
    Serial.println("ERROR: Failed to initialize Firebase");
    // Tambahkan tindakan yang sesuai untuk menangani kesalahan inisialisasi Firebase
    // Misalnya, Anda dapat mencoba kembali atau menampilkan pesan kesalahan
  }

  // Start sensors
  sensors.begin();
}

void loop() {
  // Read temperature
  sensors.requestTemperatures();
  float temperatureC = sensors.getTempCByIndex(0);
  
  if (temperatureC != DEVICE_DISCONNECTED_C) {
    if (Firebase.setFloat(firebaseData, "/Temperature", temperatureC)) {
      Serial.print("Temperature: ");
      Serial.print(temperatureC);
      Serial.println(" °C");
    } else {
      Serial.println("Failed to update temperature to Firebase");
      Serial.println("Reason: "+ firebaseData.errorReason());
    }
  } else {
    Serial.println("Error: Unable to read temperature!");
  }

  // Read air quality
  float air_quality = gasSensor.getPPM();
  if (Firebase.setFloat(firebaseData, "/Environment/AirQuality/PPM", air_quality)) {
    Serial.print("Air Quality (PPM): ");
    Serial.println(air_quality);
  } else {
    Serial.println("Failed to update air quality PPM to Firebase");
    Serial.println("Reason: " + firebaseData.errorReason());
  }

  // Delay before reading sensors again
  delay(2000);
}
