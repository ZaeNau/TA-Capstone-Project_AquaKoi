#include <OneWire.h>
#include <DallasTemperature.h>
#include <MQ135.h>
#include <DFRobot_PH.h>
#include "DFRobot_ESP_PH.h"
#include <FirebaseESP32.h>
#include <WiFi.h>

// Definisikan Firebase Database authentication
#define FIREBASE_HOST "https://ta-capstone-22597-default-rtdb.asia-southeast1.firebasedatabase.app"
#define FIREBASE_AUTH "-----BEGIN PRIVATE KEY-----\nMIIEvgIBADANBgkqhkiG9w0BAQEFAASCBKgwggSkAgEAAoIBAQC1rrolrFIYNfTN\noxB8EhwCmPc7bHtQRddOx0tBFnrPfF9XeDno0QlKFf1NvqLMKYER+boNAo2s/ZZx\n3tKNh/UI9ilxsTp20XzVsrG9Oyb+WR3vW5VZ/OrQmeBzCQ7TDNdzZIwihQef35lk\nlulJN621+fgb/RCFtwhf5PiHiOkXk5anXgr2UmaC3HFZajgNrq/4BhrgaeIw4LHk\nz7qERkls5YbrFtIvkyWCvIhiq52JGtnANby6PFFQpdUoTk2Z0fk8EryhMbBiPuVA\nNtejYgxE9MHh8ggsxAKKyQWVpQ+dB2EFWdZ4Y+VGDHwwgRsgWuzY5eHrG5xeDBE5\nEBpQlND3AgMBAAECggEASEgDHADiSmqRAg0JfmsQBMKJvfULXGTk450rZfJFGu4+\n2kRlOaiMmxKDi94306UBij7B0/I7nmLna1c8in1YMeAJngdmHKZ8lWJ6DzCM821O\nGQ/lK/+RBjvqDapBYRr/TpPmosctQOBLHTdjCbOioz8XhD8axzAKH2ivrfB819k+\nyTRlU6j0i11ys6hA50LatZtHYsh1u0mxJ0//DJw8zi5T5uY66/VPumhuF4at2QxY\n8SIdIxRE1a6VCF8Yxy/RV1cnO9XfiMQLBNXpp9L3dLdJfDloCrWgN1CF20pp+jw/\nJ2FgDxb9HvYitoYLOoOFyVyGMIbmZigeBInFOS1TzQKBgQDe2Xc8H5dX24OHzJyC\nP2Rk5+qm5OXCL2BQvuhQgT439Ns4E1eSeLJOidbfj20hoZRRu0dpCYjibGc8aGyG\nAvjVJukpbWWZ/ky6Yi9X6xv8ItT/2pRUQJqV4RNy8/IYcdx+O1fwTHiDkruQdj0r\nwyO5zZzPtZrny0fDrGqJmQJvWwKBgQDQtYuW/wDED2hdpYlamQDTzJnYag2bZChR\noAiWQKOfN8mQjNdZkv1gBSxn68wXUU1W2VJuwfZrh32tgtCt75dCXG3mh/voxJKu\nRKMbGnxlMXU/6QxBsHCUQZZ0431QrTSBDPQxdtugPn/KyQofLx7lWixXjQmtep0H\nEkg5YMbTlQKBgQDJz7qRMjLGl76Xvo6FzY7Hatcv6N7BalIZDaopLcIAvrfAIpQN\ny0v+oAl9T9AOwtsk4SscTkwucOlU5WRSQGLD9Yb1w2JdgNRPfhdN0Vb4kTq/sVze\np9rWnIwWcCDwTjzV/Dv5G+ePj9RYURu4g/HYlAHMgLQV8hu9cmjQz0ZLPQKBgQDH\nF3eKWcUsQhpnwsJtBylv4WwcssY6JmgDvWqTkiPDfV8tIf1H+Fz1nNnIZHnzAF6L\na5IkD6j22G/99Z0FX1lmN2+rCqs2V1YpIVaKQ1DI404a4kAL5bju5EYXSO9A54j/\nVhEXom9NxHD5S5/5MWUCmmtUNTk3IJDsrvbwrS3dpQKBgECj+akApvKuwLh7BDdx\nEGB1OhkcW3q9/9mWCxmHIyhynsgZc84NeEv0/GebcIeCnyn1ISSyCP3RvBh2TWq7\nnRnnK4X6sLOlMkB4emkz45pdmz6gw/iP2QY+HAz9xS0c1s4N9ATNt2LJPA84TIef\najmkArNgWOrzfnm+QaGih3f/\n-----END PRIVATE KEY-----\n"// isi dengan auth token yang ada di serial monitor
// Definisikan Wifi yang terkoneksi
#define WIFI_SSID "Kos34D_Lt2_plus"
#define WIFI_PASSWORD "Eric2010"

// Definisikan pin yang digunakan untuk koneksi ke sensor suhu
#define ONE_WIRE_BUS 2 
#define MQ_sensor 33
#define TDS_Pin 32
#define PH_PIN 34

#define RL 10 // Nilai resistor RL adalah 47K 
#define m -0.417 // Masukkan Kemiringan yang dihitung  
#define b 0.425 // Masukkan intersep yang dihitung 
#define Ro 13 // Masukkan nilai Ro yang ditemukan
#define ESPADC 4096.0 // Nilai konversi Analog ke Digital pada ESP
#define ESPVOLTAGE 3300 // Nilai tegangan yang digunakan oleh ESP (dalam mV)

OneWire oneWire(ONE_WIRE_BUS); // Inisialisasi instance OneWire untuk komunikasi dengan sensor suhu
DallasTemperature sensors(&oneWire); // Inisialisasi instance DallasTemperature untuk membaca suhu dari sensor
MQ135 gasSensor(MQ_sensor); // Inisialisasi instance MQ135 untuk membaca kualitas udara
DFRobot_ESP_PH ph;

// inisialisasi Data untuk firebase
FirebaseData firebaseData;

const int numReadings = 5; // Nilai pembacaan sample sebesar 5 kali
float readings[numReadings];
int readIndex = 0;
float total = 0;
float average = 0;
float temperature; // Variabel untuk menyimpan nilai suhu
float voltage; // Variabel untuk menyimpan nilai tegangan

void setup() {
  Serial.begin(9600); // Mulai komunikasi serial untuk debugging
  WiFi.begin(WIFI_SSID, WIFI_PASSWORD); // Mulai menkoneksikan dengan WiFi
  while (WiFi.status() != WL_CONNECTED) {
    delay(500);
    Serial.print(".");
  }
  Serial.println("Connected to Wi-Fi");
  Firebase.begin(FIREBASE_HOST, FIREBASE_AUTH);
  signInUser("user@gmail.com", "password123"); // Sign in Authenticated users
  sensors.begin(); // Mulai komunikasi dengan sensors 
}
//Proses Send/Read antara ESP32 dan Firebase
void loop() {
  if (Firebase.authenticated()) { 
    sensors.requestTemperatures(); // Permintaan pembacaan suhu
    temperature = sensors.getTempCByIndex(0); // Baca suhu dan simpan dalam variabel temperature
    // Periksa apakah pembacaan suhu valid
    if (temperature != DEVICE_DISCONNECTED_C) {
      // Lakukan kalibrasi suhu
      temperature = 1.0465 * temperature - 1.3365;
      // Tampilkan suhu ke Serial Monitor
      Serial.print("Suhu: ");
      Serial.print(temperature);
      Serial.println(" °C");
      // Upload temperature data to Firebase
      uploadTemperature(temperature);
    } else {
      // Tampilkan pesan kesalahan jika pembacaan tidak valid
      Serial.println("Error: Tidak dapat membaca suhu!");
    }
    // Baca kualitas udara dari sensor MQ135
    float VRL = analogRead(MQ_sensor) * (3.3 / 4095.0); // Voltage drop across the MQ sensor
    float RS = (3.3 / VRL - 1) * 10; // Sensor resistance at gas concentration
    float ratio = RS / Ro;
    float ppm = pow(10, ((log10(ratio) - b) / m)); // Use formula to calculate ppm

    total = total - readings[readIndex];
    readings[readIndex] = ppm;
    total = total + readings[readIndex];
    readIndex = readIndex + 1;

    if (readIndex >= numReadings) {
      readIndex = 0;
    }

    average = total / numReadings;

    Serial.print("Amonia ppm: ");
    Serial.println(average); // Menampilkan nilai rata-rata ppm ke Serial Monitor
    uploadAmonia(average);

    // Baca nilai sensor TDS
    int sensorValue = analogRead(TDS_Pin);
    Serial.print("TDS Value: ");
    Serial.println(sensorValue);

    // Kalibrasi nilai TDS
    float tdsValue = (0.6656 * sensorValue) + 69.604;
    uploadTds(tdsValue);

    // Baca tegangan dari sensor pH
    voltage = analogRead(PH_PIN) / ESPADC * ESPVOLTAGE;

    // Baca nilai pH dengan kompensasi suhu
    float phValue = ph.readPH(voltage, temperature);

    // Koreksi nilai pH menggunakan regresi linear
    float corrected_pH = (-0.4869 * phValue) + 9.5045;

    // Tampilkan nilai pH ke Serial Monitor
    Serial.print("pH:");
    Serial.println(phValue, 4);
    uploadPH(phValue);

    // Lakukan kalibrasi pH
    ph.calibration(voltage, temperature);

    delay(10000); // Tunda selama 10 detik sebelum membaca sensor lagi
  }
}

// mengecek user terauthentikasi 
void signInUser(const char* email, const char* password) {
  Firebase.authWithPassword(firebaseData, email, password);
  while (firebaseData.status != FirebaseData::STATUS_OK && firebaseData.status != FirebaseData::STATUS_TIMEOUT) {
    delay(100);
  }
  if (firebaseData.status == FirebaseData::STATUS_OK) {
    Serial.println("Authentication successful");
    //Dapatkan Token autentikasi
    String authToken = firebaseData.authToken();
    //Pakai autentikasi token untuk akses database
    Serial.print("Authentication token: ");
    Serial.println(authToken);
  } else {
    Serial.println("Authentication failed");
  }
}

//Upload data ke Firebase
void uploadTemperature(float temp) {
  if (Firebase.setFloat(firebaseData, "sensorData/temperature", temp)) {
    Serial.println("Temperature uploaded to Firebase");
  } else {
    Serial.println("Error uploading temperature");
  }
}

void uploadAmonia(float ppm) {
  if (Firebase.setFloat(firebaseData, "sensorData/amonia_ppm", ppm)) {
    Serial.println("Amonia ppm uploaded to Firebase");
  } else {
    Serial.println("Error uploading amonia ppm");
  }
}

void uploadTds(float TDS) {
  if (Firebase.setFloat(firebaseData, "sensorData/TDS", TDS)) {
    Serial.println("TDS Value uploaded to Firebase");
  } else {
    Serial.println("Error uploading TDS Value");
  }
}

void uploadPH(float pH) {
  if (Firebase.setFloat(firebaseData, "sensorData/pH", pH)) {
    Serial.println("pH value uploaded to Firebase");
  } else {
    Serial.println("Error uploading pH");
  }
}
