#include <WiFi.h>
#include <Firebase_ESP_Client.h>
#include <OneWire.h>
#include <DallasTemperature.h>
#include <MQ135.h>
#include <DFRobot_PH.h>

#include "addons/TokenHelper.h"
#include "addons/RTDBHelper.h"
<<<<<<< Updated upstream
=======

#define WIFI_SSID "POCO F4"
#define WIFI_PASSWORD "123nau123"

#define API_KEY "AIzaSyBN2McacTs5kKbfS2Lc5umzutLqZkHuQso"
#define DATABASE_URL "https://ta-capstone-22597-default-rtdb.asia-southeast1.firebasedatabase.app/"

#define USER_EMAIL "test@tester.com"
#define USER_PASSWORD "password123"

#define ONE_WIRE_BUS 2
#define MQ_sensor 33
#define TDS_Pin 32
#define PH_PIN 34
#define sensorPin A0
>>>>>>> Stashed changes

#define WIFI_SSID "kos34D_Lt2_plus"
#define WIFI_PASSWORD "Eric2010"

#define API_KEY "AIzaSyBN2McacTs5kKbfS2Lc5umzutLqZkHuQso"
#define DATABASE_URL "https://ta-capstone-22597-default-rtdb.asia-southeast1.firebasedatabase.app/"

#define USER_EMAIL "test@tester.com"
#define USER_PASSWORD "password123"

#define ONE_WIRE_BUS 2
#define MQ_sensor 33
#define TDS_Pin 32
#define PH_PIN 34
#define sensorPin A0
#define RL 10
#define m -0.417
#define b 0.425
#define Ro 13
#define ESPADC 4096.0
#define ESPVOLTAGE 3300
OneWire oneWire(ONE_WIRE_BUS);
DallasTemperature sensors(&oneWire);
MQ135 gasSensor(MQ_sensor);
DFRobot_ESP_PH ph;
DFRobot_PH ph;

<<<<<<< Updated upstream
const int numReadings = 5;
float readings[numReadings];
int readIndex = 0;
float total = 0;
float average = 0;
float temperature;
float voltage;
int currentIndex = 0;
FirebaseData fbdo;
FirebaseAuth auth;
FirebaseConfig config;
String uid;
String databasePath;

String tempPath = "/temperature";
String amoPath = "/amonia";
String tdsPath = "/tds";
String phPath = "/ph";
String turbPath = "/turbidity";
String timePath = "/timestamp";
String parentPath;

int timestamp;

FirebaseJson json;
const char* ntpServer = "pool.ntp.org";
=======
OneWire oneWire(ONE_WIRE_BUS);
DallasTemperature sensors(&oneWire);
MQ135 gasSensor(MQ_sensor);
DFRobot_ADC_PH ph;

const int numReadings = 5;
float readings[numReadings];
int readIndex = 0;
float total = 0;
float average = 0;
float temperature;
float voltage;
float phValue;
int sensorValue;
int kekeruhan;

int currentIndex = 0;

FirebaseData fbdo;
FirebaseAuth auth;
FirebaseConfig config;
String uid;
String databasePath;

String tempPath = "/temperature";
String amoPath = "/amonia";
String tdsPath = "/tds";
String phPath = "/ph";
String turbPath = "/turbidity";
String parentPath;

FirebaseJson json;
>>>>>>> Stashed changes

unsigned long sendDataPrevMillis = 0;
unsigned long timerDelay = 180000;

bool signInOK = false;

// Initialize WiFi
void initWiFi() {
  WiFi.begin(WIFI_SSID, WIFI_PASSWORD);
  Serial.print("Connecting to WiFi ..");
  while (WiFi.status() != WL_CONNECTED) {
    Serial.print('.');
    delay(1000);
  }
  Serial.println(WiFi.localIP());
  Serial.println();
}

// Function declarations
void readTemperature();
void readAirQuality();
void readTDS();
void readPH();
void readTurbidity();
<<<<<<< Updated upstream

// Function that gets current epoch time
unsigned long getTime() {
  time_t now;
  struct tm timeinfo;
  if (!getLocalTime(&timeinfo)) {
    //Serial.println("Failed to obtain time");
    return(0);
  }
  time(&now);
  return now;
}
=======
>>>>>>> Stashed changes

void setup() {
  Serial.begin(9600);
  sensors.begin();
<<<<<<< Updated upstream

  WiFi.begin(WIFI_SSID, WIFI_PASSWORD);
  while (WiFi.status() != WL_CONNECTED) {
    delay(1000);
    Serial.println("Connecting to WiFi..");
  }
  Serial.println("Connected to WiFi");

  initWiFi();
  configTime(0, 0, ntpServer);
  config.api_key = API_KEY;
  config.database_url = DATABASE_URL;

  // Autentikasi pengguna Firebase
  if (Firebase.signInWithEmailAndPassword(&config, &auth, "user@gmail.com", "password123")) {
    Serial.println("Sign in successful");
    signInOK = true;
  } else {
    Serial.println("Sign in failed");
  }
  config.token_status_callback = tokenStatusCallback;
  auth.user.email = USER_EMAIL;
  auth.user.password = USER_PASSWORD;
  // Assign the callback function for the long running token generation task
  config.token_status_callback = tokenStatusCallback; //see addons/TokenHelper.h
  // Assign the maximum retry of token generation
  config.max_token_generation_retry = 5;
  // Initialize the library with the Firebase authen and config
  Firebase.begin(&config, &auth);
  Firebase.reconnectWiFi(true);
  // Getting the user UID might take a few seconds
  Serial.println("Getting User UID");
  while ((auth.token.uid) == "") {
  Serial.print('.');
  delay(1000);
  }
=======
  initWiFi();
  config.api_key = API_KEY;
  config.database_url = DATABASE_URL;
  auth.user.email = USER_EMAIL;
  auth.user.password = USER_PASSWORD;
  // Assign the callback function for the long running token generation task
  config.token_status_callback = tokenStatusCallback; //see addons/TokenHelper.h
  // Assign the maximum retry of token generation
  config.max_token_generation_retry = 5;
  // Initialize the library with the Firebase authen and config
  Firebase.begin(&config, &auth);
  // Getting the user UID might take a few seconds
  Serial.println("Getting User UID");
  while ((auth.token.uid) == "") {
  Serial.print('.');
  delay(1000);
  }
>>>>>>> Stashed changes
  uid = auth.token.uid.c_str();
  Serial.print("User UID: ");
  Serial.print(uid);
  // Update database path
<<<<<<< Updated upstream
  databasePath = "/UsersData/" + uid + "/readings";
}

void loop() {
  if (Firebase.ready() && signInOK && (millis() - sendDataPrevMillis > 15000 || sendDataPrevMillis == 0)) {
  if (Firebase.ready() && (millis() - sendDataPrevMillis > timerDelay || sendDataPrevMillis == 0)) {
    sendDataPrevMillis = millis();

    timestamp = getTime();
    parentPath = databasePath + "/" + String(timestamp);

    readTemperature();
    json.set(tempPath.c_str(), String(temperature)); // Assuming temperature is a float or int

    readAirQuality();
    readTDS();
    readPH();
    readTurbidity();
    json.set(amoPath.c_str(), String(average)); // Assuming average is a float or int

    // Declare and initialize sensorValue, phValue, and kekeruhan variables
    int sensorValue = analogRead(TDS_Pin);
    float phValue = analogRead(PH_PIN) / ESPADC * ESPVOLTAGE;
    int kekeruhan = analogRead(sensorPin);

    // Now you can use these variables in your json.set() calls
    json.set(tdsPath.c_str(), String(sensorValue)); // Assuming sensorValue is an int or float
    json.set(phPath.c_str(), String(phValue)); // Assuming phValue is a float
    json.set(turbPath.c_str(), String(kekeruhan)); // Assuming kekeruhan is an int

    json.set(timePath, String(timestamp));

    String jsonData;
    json.toString(jsonData); // Convert JSON object to string
    Serial.println("JSON Data: " + jsonData); // Print JSON data for debugging

    Serial.printf("Set json... %s\n", Firebase.RTDB.setJSON(&fbdo, parentPath.c_str(), &json) ? "ok" : fbdo.errorReason().c_str());

=======
  databasePath = "/UsersData/" + uid + "/Sensors";
}

void loop() {
  if (Firebase.ready() && (millis() - sendDataPrevMillis > timerDelay || sendDataPrevMillis == 0)) {
    sendDataPrevMillis = millis();
    timestamp = getTime();
    parentPath = databasePath + "/";
    
    readTemperature();
    json.set(tempPath.c_str(), String(temperature)); // Assuming temperature is a float or int
    
    readAirQuality();
    json.set(amoPath.c_str(), String(average)); // Assuming average is a float or int
    // Now you can use these variables in your json.set() calls
    readTDS();
    json.set(tdsPath.c_str(), String(sensorValue)); // Assuming sensorValue is an int or float
    readPH();
    json.set(phPath.c_str(), String(phValue)); // Assuming phValue is a float
    readTurbidity();
    json.set(turbPath.c_str(), String(kekeruhan)); // Assuming kekeruhan is an int

    String jsonData;
    json.toString(jsonData); // Convert JSON object to string
    Serial.println("JSON Data: " + jsonData); // Print JSON data for debugging
    
    Serial.printf("Set json... %s\n", Firebase.RTDB.setJSON(&fbdo, parentPath.c_str(), &json) ? "ok" : fbdo.errorReason().c_str());
    
>>>>>>> Stashed changes
    delay(10000);
  }
}

<<<<<<< Updated upstream
void readTemperature() {
=======
>>>>>>> Stashed changes

void readTemperature(){
  sensors.requestTemperatures(); // Meminta pembacaan suhu dari sensor
  temperature = sensors.getTempCByIndex(0); // Mendapatkan nilai suhu dari sensor
  temperature = 1.0465 * temperature - 1.3365; // Melakukan kalibrasi Regresi Linear suhu
  Serial.print("Suhu: "); // Output ke Serial Monitor
  Serial.print(temperature); // Output nilai suhu
  Serial.println(" °C"); // Output satuan suhu
<<<<<<< Updated upstream
  if(Firebase.RTDB.setFloat(&fbdo, "Sensors/Suhu",temperature)){
    Serial.println();Serial.print(temperature);
    Serial.print("- successfully saved to: " + fbdo.dataPath());
    Serial.println(" (" +fbdo.dataType() + ")");
  } else {
    Serial.println("FAILED" +fbdo.errorReason());
  }
}

void readAirQuality() {
=======
}

>>>>>>> Stashed changes
void readAirQuality(){
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
  if(Firebase.RTDB.setFloat(&fbdo, "Sensors/Amonia",average)){
    Serial.println();Serial.print(average);
    Serial.print("- successfully saved to: " + fbdo.dataPath() + "ppm");
    Serial.println(" (" +fbdo.dataType() + ")");
  } else {
    Serial.println("FAILED" +fbdo.errorReason());
  }
}

<<<<<<< Updated upstream
void readTDS() {
=======
>>>>>>> Stashed changes
void readTDS(){
  int sensorValue = analogRead(TDS_Pin); // Membaca nilai analog dari sensor TDS
  float tdsValue = (0.6656 * sensorValue) + 69.604; // Melakukan kalibrasi nilai TDS
  Serial.print("TDS Value: "); // Output ke Serial Monitor
  Serial.println(sensorValue); // Output nilai TDS
<<<<<<< Updated upstream
  if(Firebase.RTDB.setFloat(&fbdo, "Sensors/TDS",sensorValue)){
    Serial.println();Serial.print(sensorValue);
    Serial.print("- successfully saved to: " + fbdo.dataPath());
    Serial.println(" (" +fbdo.dataType() + ")");
  } else {
    Serial.println("FAILED" +fbdo.errorReason());
  }
}

void readPH() {
=======
}

>>>>>>> Stashed changes
void readPH(){
  voltage = analogRead(PH_PIN) / ESPADC * ESPVOLTAGE; // Membaca tegangan dari sensor pH
  float phValue = ph.readPH(voltage, temperature); // Mendapatkan nilai pH dari sensor
  float corrected_pH = (-0.4869 * phValue) + 9.5045; // Koreksi nilai pH
  Serial.print("pH:"); // Output ke Serial Monitor
  Serial.println(phValue, 4); // Output nilai pH
<<<<<<< Updated upstream
  if(Firebase.RTDB.setFloat(&fbdo, "Sensors/Ph",phValue)){
    Serial.println();Serial.print(phValue);
    Serial.print("- successfully saved to: " + fbdo.dataPath());
    Serial.println(" (" +fbdo.dataType() + ")");
  } else {
    Serial.println("FAILED" +fbdo.errorReason());
  }
}

void readTurbidity() {
=======
}

>>>>>>> Stashed changes
void readTurbidity(){
  int Turbidity = analogRead(sensorPin); // Membaca nilai dari sensor kekeruhan air
  total = total - readings[currentIndex]; // Mengupdate total pembacaan
  readings[currentIndex] = Turbidity; // Menyimpan pembacaan sensor ke dalam array
  total = total + readings[currentIndex]; // Mengupdate total pembacaan
  currentIndex = (currentIndex + 1) % numReadings; // Pindah ke indeks berikutnya, atur kembali ke 0 jika sudah mencapai batas
  int average = total / numReadings; // Menghitung rata-rata pembacaan sensor
  int kekeruhan = map(average, 0, 700, 100, 0); // Konversi nilai sensor ke nilai kekeruhan dalam rentang 0-100
  Serial.print("Kekeruhan Air : "); // Output ke Serial Monitor
  Serial.println(kekeruhan); // Output nilai kekeruhan air
  if(Firebase.RTDB.setFloat(&fbdo, "Sensors/Turbidity",kekeruhan)){
    Serial.println();Serial.print(kekeruhan);
    Serial.print("- successfully saved to: " + fbdo.dataPath());
    Serial.println(" (" +fbdo.dataType() + ")");
  } else {
    Serial.println("FAILED" +fbdo.errorReason());
  }
}
