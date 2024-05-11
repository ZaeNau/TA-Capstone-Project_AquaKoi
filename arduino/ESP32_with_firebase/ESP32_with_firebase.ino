#include <WiFi.h>
#include <FirebaseESP32.h>
#include <OneWire.h>
#include <DallasTemperature.h>
#include <MQ135.h>
#include <DFRobot_PH.h>
#include <DFRobot_ESP_PH.h>

#define ONE_WIRE_BUS 2  // Pin untuk sensor Temparture
#define MQ_sensor 33    // Pin untuk sensor Gas Amonis
#define TDS_Pin 32      // Pin untuk sensor TDS
#define PH_PIN 34       // Pin untuk sensor PH
#define sensorPin A0    // Pin untuk sensor kekeruhan

#define RL 10
#define m -0.417
#define b 0.425
#define Ro 13
#define ESPADC 4096.0
#define ESPVOLTAGE 3300

OneWire oneWire(ONE_WIRE_BUS); // Inisialisasi OneWire untuk sensor suhu
DallasTemperature sensors(&oneWire); // Inisialisasi DallasTemperature untuk pembacaan suhu
MQ135 gasSensor(MQ_sensor); // Inisialisasi MQ135 untuk pembacaan kualitas udara
DFRobot_ESP_PH ph; // Inisialisasi DFRobot_ESP_PH untuk pembacaan pH

const char *ssid = "Kos34D_Lt2_plus"; // Nama WiFi
const char *password = "Eric2010"; // Kata sandi WiFi

const char *firebaseHost = "https://ta-capstone-22597-default-rtdb.asia-southeast1.firebasedatabase.app/"; // URL Firebase Realtime Database
const char *authToken = "AIzaSyBN2McacTs5kKbfS2Lc5umzutLqZkHuQso"; // Token API Firebase
const char *email = "user@gmail.com"; // Email pengguna Firebase
const char *passwordFirebase = "password123"; // Kata sandi pengguna Firebase

const int numReadings = 5; // Jumlah pembacaan untuk perhitungan rata-rata
float readings[numReadings]; // Array untuk menyimpan pembacaan sensor
int readIndex = 0; // Indeks pembacaan saat ini
float total = 0; // Total pembacaan untuk perhitungan rata-rata
float average = 0; // Nilai rata-rata pembacaan
float temperature; // Variabel untuk menyimpan nilai suhu
float voltage; // Variabel untuk menyimpan nilai tegangan
int currentIndex = 0; // Indeks saat ini untuk pembacaan sensor kekeruhan

FirebaseData fbdo; // Deklarasi objek FirebaseObject untuk koneksi Firebase

void setup() {
  Serial.begin(9600); // Memulai komunikasi serial untuk debugging
  sensors.begin(); // Memulai komunikasi dengan sensor suhu
  
  // Inisialisasi koneksi WiFi
  WiFi.begin(ssid, password);
  while (WiFi.status() != WL_CONNECTED) {
    delay(1000);
    Serial.println("Connecting to WiFi..");
  }
  Serial.println("Connected to WiFi");

  // Inisialisasi koneksi Firebase
  Firebase.begin(firebaseHost, authToken, email, passwordFirebase);
}

void loop() {
  readTemperature(); // Memanggil fungsi untuk membaca suhu
  readAirQuality(); // Memanggil fungsi untuk membaca kualitas udara
  readTDS(); // Memanggil fungsi untuk membaca nilai TDS
  readPH(); // Memanggil fungsi untuk membaca nilai pH
  readTurbidity(); // Memanggil fungsi untuk membaca kekeruhan air
  delay(10000); // Tunggu 10 detik sebelum membaca sensor lagi
}

void readTemperature() {
  sensors.requestTemperatures(); // Meminta pembacaan suhu dari sensor
  temperature = sensors.getTempCByIndex(0); // Mendapatkan nilai suhu dari sensor
  temperature = 1.0465 * temperature - 1.3365; // Melakukan kalibrasi Regresi Linear suhu
  Serial.print("Suhu: "); // Output ke Serial Monitor
  Serial.print(temperature); // Output nilai suhu
  Serial.println(" °C"); // Output satuan suhu
}

void readAirQuality() {
  float VRL = analogRead(MQ_sensor) * (3.3 / 4095.0); // Membaca tegangan dari sensor MQ
  float RS = (3.3 / VRL - 1) * 10; // Menghitung resistansi sensor
  float ratio = RS / Ro; // Menghitung rasio Rs/Ro
  float ppm = pow(10, ((log10(ratio) - b) / m)); // Menghitung ppm berdasarkan rasio
  total = total - readings[readIndex]; // Mengupdate total pembacaan
  readings[readIndex] = ppm; // Menyimpan pembacaan ppm ke dalam array
  total = total + readings[readIndex]; // Mengupdate total pembacaan
  readIndex = readIndex + 1; // Mengupdate indeks pembacaan
  if (readIndex >= numReadings) { // Memastikan indeks pembacaan tetap dalam rentang array
    readIndex = 0; // Kembali ke indeks awal jika melebihi jumlah pembacaan
  }
  average = total / numReadings; // Menghitung nilai rata-rata ppm
  Serial.print("Amonia ppm: "); // Output ke Serial Monitor
  Serial.println(average); // Output nilai rata-rata ppm

  // Setelah mendapatkan nilai average, simpan ke Firebase
  Firebase.setInt(fbdo, "/amonium_ppm", average);
}

void readTDS() {
  int sensorValue = analogRead(TDS_Pin); // Membaca nilai analog dari sensor TDS
  float tdsValue = (0.6656 * sensorValue) + 69.604; // Melakukan kalibrasi nilai TDS
  Serial.print("TDS Value: "); // Output ke Serial Monitor
  Serial.println(sensorValue); // Output nilai TDS

  // Setelah mendapatkan nilai sensorValue, simpan ke Firebase
  Firebase.setInt(fbdo, "/tds_value", sensorValue);
}

void readPH() {
  voltage = analogRead(PH_PIN) / ESPADC * ESPVOLTAGE; // Membaca tegangan dari sensor pH
  float phValue = ph.readPH(voltage, temperature); // Mendapatkan nilai pH dari sensor
  float corrected_pH = (-0.4869 * phValue) + 9.5045; // Koreksi nilai pH
  Serial.print("pH:"); // Output ke Serial Monitor
  Serial.println(phValue, 4); // Output nilai pH

  // Setelah mendapatkan nilai phValue, simpan ke Firebase
  Firebase.setFloat(fbdo, "/ph_value", phValue);
}

void readTurbidity() {
  int Turbidity = analogRead(sensorPin); // Membaca nilai dari sensor kekeruhan air
  total = total - readings[currentIndex]; // Mengupdate total pembacaan
  readings[currentIndex] = Turbidity; // Menyimpan pembacaan sensor ke dalam array
  total = total + readings[currentIndex]; // Mengupdate total pembacaan
  currentIndex = (currentIndex + 1) % numReadings; // Pindah ke indeks berikutnya, atur kembali ke 0 jika sudah mencapai batas
  int average = total / numReadings; // Menghitung rata-rata pembacaan sensor
  int kekeruhan = map(average, 0, 700, 100, 0); // Konversi nilai sensor ke nilai kekeruhan dalam rentang 0-100
  Serial.print("Kekeruhan Air : "); // Output ke Serial Monitor
  Serial.println(kekeruhan); // Output nilai kekeruhan air

  // Setelah mendapatkan nilai kekeruhan, simpan ke Firebase
  Firebase.setInt(fbdo, "/turbidity", kekeruhan);
}
