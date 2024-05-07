#include <OneWire.h>
#include <DallasTemperature.h>
#include <MQ135.h>
#include <DFRobot_PH.h>
#include "DFRobot_ESP_PH.h"
#include <FirebaseESP32.h>
#include <WiFi.h>

// Definisikan Firebase Database authentication
#define FIREBASE_HOST "https://ta-capstone-22597-default-rtdb.asia-southeast1.firebasedatabase.app/"
#define FIREBASE_AUTH "-----BEGIN PRIVATE KEY-----\nMIIEvwIBADANBgkqhkiG9w0BAQEFAASCBKkwggSlAgEAAoIBAQCT+kZLbHmQGZDB\nZT2PZZsw88yL/vqDotWbvek5ZGDz7O5vH/7A6kVmGsI/17aVveEGcJWtOngcSu31\nmdaNrIP4KYA3gvG+za+DBtoxeKP9ZYmeKhh53/8ZCGx8nK5+7dhgv/fDzhoBMd49\njBLc5jSeeozXHPogfqI+RYU2XlPrTJgtiiCcqVP3+/Kb9RUxrrp8qqgdb5qVfvaG\ncZljnUaQxG8SuKPpJKtQ8oMX98n5GVWcrqPAxNEOKIivbSSyId1bYgcH4MKDouaL\nr4bhoMjJMvNbYryU2A3sq7pAnYf4VocX2D/vr0PD+WwurhvFXVx+/m8MgJphV/O5\n+wsC5PWxAgMBAAECggEAATHfoxiZ9gJm1fuXHtMfXiqnHP2ZkI+I3FbmYlq/olM9\nl53Gr6W/RV7zm5KxJuNfb5m1c650WCd4urzGa+LCjAdAbEen47ZYc504t3aLExmL\nSMDRQsapZ3kscGh5djfoa9uQ82lKHMwGHdwa2OLDoQCfUNYAj7DwvBemnDTwcNwX\nJ5n7+ntbW0ww2TnHitmrD8PZJ0FUDPc/08WhEItVhvu89mzoBxeFE6LK3bfv82+0\nP47YZfpZP76S4WzPLHtitS3BohHNdWN9T3myHYhjeC2LYJatrZmN45hIXpoQ9abJ\nhkWWneWh5FHqhzlQo9IQxd2LRLbJkugX/rtM4xBdAQKBgQDHWSgSeEpcK6v1uQXn\nYlvY2Kulrtkmmx+/yZHDbaUfsKSXgkLWqbGmT+9TzjOxg/j1EijXnhOCk3zh2Z+q\n6E6v4oGgbXf+fOkauXfTVb0Gw63SoGCLVk9NKU182uB3//DTfV3t6/hqIpDGDfaO\niB6m0Q2jrlfmf2r9HT2JvmQ+kQKBgQC+B9abgLD3UflSEnGrcvsy3gM94wa0BGLc\nlU5guL1WiROxbYe5aesTmm8RC+/09fqNkStusLlCgD01eFdiv6MHyXF25NyeCadQ\n9UnhO9KAhJYIjsvhSTnm/X/12pozV5UbgcAef8OH0G2kC1hkxy8aVsmfyJBA5Bop\n5ZFDKucVIQKBgQCgJ7TWAeZb3oosxBVGK/N2Z7yfQ7YaGg6L2rlMtM4wg434WyKv\nq22aHCY+wi8tssVUvt4pPEqYYT23hUuN101AaU2TQd9hiaENY2wtUXin8pW33jky\nOIlFiKVEZeRpBCrK/rFz8FyHiHWfaKBpKlrV0qaOlgbwm/WsnM1P2LJYwQKBgQCf\nHvcf/PGyFq0bgSA3fS9El8zFHH33bRjPNiKMMQUyGdQopNuacUuLfax07LcAOpyT\nwDRLGqX2PmWCiYM6x9ce5RoigV8O4mx9CPfVJv+L5/mtrsyfl25psmlcl7C5PyQ3\nBT23DCrRZcD5NRrOQE970aJBLnNEMvyJipZJVPpsoQKBgQC/b1DTQiwrw7X9iZNR\nQK6OOTQgwjzIOo4eOBJ7Yh+f1sxlVDv0G7c5kTqWHHlnnKJiJHS8Kl6FtnnlKV0r\n74MEmDm1knmWSx2Ry3XGlQ+I4IeMaoYNMmKs0MNdIFqkwzupYkGEXM8RiGzaCaS1\ni3b2Rpq+zIZ+UZPAPsAOGy8ZjA==\n-----END PRIVATE KEY-----\n"// isi dengan auth token yang ada di serial monitor
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
  signInUser("test@email.com", "TA123456"); // Sign in Authenticated users
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
