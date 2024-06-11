#include <WiFi.h>
#include <Firebase_ESP_Client.h>
#include <OneWire.h>
#include <DallasTemperature.h>
#include <MQ135.h>
#include <DFRobot_PH.h>

#include "addons/TokenHelper.h"
#include "addons/RTDBHelper.h"

#define WIFI_SSID "Kos34D"
#define WIFI_PASSWORD "Kos34D2024"

#define API_KEY "AIzaSyBN2McacTs5kKbfS2Lc5umzutLqZkHuQso"
#define DATABASE_URL "https://ta-capstone-22597-default-rtdb.asia-southeast1.firebasedatabase.app/"

#define USER_EMAIL "user@gmail.com"
#define USER_PASSWORD "password123"

#define ONE_WIRE_BUS 2
#define MQ_SENSOR 33
#define TDS_PIN 32
#define PH_PIN 34
#define TURBIDITY_SENSOR_PIN A0

#define RELAY_CHILLER 16
#define RELAY_HEATER 17
#define RELAY_WATERPUMP 18

#define MIN_TEMPERATURE 20
#define MAX_TEMPERATURE 28
#define MIN_AMONIA 0
#define MAX_AMONIA 0.2
#define MIN_TDS 0
#define MAX_TDS 100
#define MIN_PH 0
#define MAX_PH 14
#define MIN_TURBIDITY 0
#define MAX_TURBIDITY 37

OneWire oneWire(ONE_WIRE_BUS);
DallasTemperature sensors(&oneWire);
MQ135 gasSensor(MQ_SENSOR);
DFRobot_PH phSensor;

FirebaseData fbdo;
FirebaseAuth auth;
FirebaseConfig config;
String uid;
String databasePath;

FirebaseJson json;

unsigned long sendDataPrevMillis = 0;
unsigned long timerDelay = 5000;

void initWiFi() {
  WiFi.begin(WIFI_SSID, WIFI_PASSWORD);
  Serial.print("Connecting to WiFi ..");
  while (WiFi.status() != WL_CONNECTED) {
    Serial.print('.');
    delay(500);
  }
  Serial.println(WiFi.localIP());
  Serial.println();
}

void setup() {
  Serial.begin(115200);
  sensors.begin();

  pinMode(RELAY_HEATER, OUTPUT);
  pinMode(RELAY_CHILLER, OUTPUT);
  pinMode(RELAY_WATERPUMP, OUTPUT);

  initWiFi();
  config.api_key = API_KEY;
  config.database_url = DATABASE_URL;
  auth.user.email = USER_EMAIL;
  auth.user.password = USER_PASSWORD;
  config.token_status_callback = tokenStatusCallback;
  config.max_token_generation_retry = 5;
  Firebase.begin(&config, &auth);

  Serial.println("Getting User UID");
  while (auth.token.uid == "") {
    Serial.print('.');
    delay(500);
  }
  uid = auth.token.uid.c_str();
  Serial.print("User UID: ");
  Serial.print(uid);

  databasePath = "/UsersData/" + uid;
}

void loop() {
  readTemperature();
  delay(2000);
  readAirQuality();
  delay(2000);
  readTDS();
  delay(2000);
  readPH();
  delay(2000);
  readTurbidity();
  delay(2000);
  controlRelays();
  updateRelayStates();
  
  if (Firebase.ready() && (millis() - sendDataPrevMillis > timerDelay || sendDataPrevMillis == 0)) {
    sendDataPrevMillis = millis();
    String sensorPath = databasePath + "/Sensors/";

    json.set("/Suhu", String(temperature));
    json.set("/SuhuPercentage", String(temperaturePercentage));
    json.set("/Amonia", String(amonia));
    json.set("/AmoniaPercentage", String(amoniaPercentage));
    json.set("/Tds", String(tdsValue));
    json.set("/TdsPercentage", String(tdsPercentage));
    json.set("/ph", String(pHValue));
    json.set("/phPercentage", String(pHPercentage));
    json.set("/turbidity", String(turbidity));
    json.set("/turbidityPercentage", String(turbidityPercentage));

    String jsonData;
    json.toString(jsonData);
    Serial.println("JSON Data: " + jsonData);

    Serial.printf("Set json... %s\n", Firebase.RTDB.setJSON(&fbdo, sensorPath.c_str(), &json) ? "ok" : fbdo.errorReason().c_str());
    
    delay(1000);
  }
}

void updateRelayStates() {
  if (Firebase.ready() && (millis() - sendDataPrevMillis > timerDelay || sendDataPrevMillis == 0)) {
    sendDataPrevMillis = millis();
    String relayPath = databasePath + "/relayState/";

    json.set("chiller", digitalRead(RELAY_CHILLER) == HIGH ? "1" : "0");
    json.set("heater", digitalRead(RELAY_HEATER) == HIGH ? "1" : "0");
    json.set("waterpump", digitalRead(RELAY_WATERPUMP) == HIGH ? "1" : "0");

    String jsonData;
    json.toString(jsonData);
    Serial.println("JSON Data: " + jsonData);

    Serial.printf("Set json... %s\n", Firebase.RTDB.setJSON(&fbdo, relayPath.c_str(), &json) ? "ok" : fbdo.errorReason().c_str());

    delay(1000);
  }
}

void controlRelays() {
  if (temperature < MIN_TEMPERATURE) {
    digitalWrite(RELAY_HEATER, HIGH);
    digitalWrite(RELAY_CHILLER, LOW);
  } else if (temperature > MAX_TEMPERATURE) {
    digitalWrite(RELAY_CHILLER, HIGH);
    digitalWrite(RELAY_HEATER, LOW);
  } else {
    digitalWrite(RELAY_CHILLER, LOW);
    digitalWrite(RELAY_HEATER, LOW);
  }

  if (tdsValue < MIN_TDS || tdsValue > MAX_TDS) {
    digitalWrite(RELAY_WATERPUMP, HIGH);
  } else {
    digitalWrite(RELAY_WATERPUMP, LOW);
  }
}

void readTemperature() {
  sensors.requestTemperatures();
  temperature = sensors.getTempCByIndex(0);
  temperaturePercentage = map(temperature, MIN_TEMPERATURE, MAX_TEMPERATURE, 0, 100);
  temperaturePercentage = constrain(temperaturePercentage, 0, 100);
  Serial.println("Temperature: " + String(temperature));
  Serial.println("Temperature Percentage: " + String(temperaturePercentage));
}

void readAirQuality() {
  amonia = gasSensor.getPPM();
  amoniaPercentage = map(amonia, MIN_AMONIA, MAX_AMONIA, 0, 100);
  amoniaPercentage = constrain(amoniaPercentage, 0, 100);
  Serial.println("Air Quality (Amonia): " + String(amonia));
  Serial.println("Amonia Percentage: " + String(amoniaPercentage));
}

void readTDS() {
  tdsValue = analogRead(TDS_PIN);
  tdsPercentage = map(tdsValue, MIN_TDS, MAX_TDS, 0, 100);
  tdsPercentage = constrain(tdsPercentage, 0, 100);
  Serial.println("TDS: " + String(tdsValue));
  Serial.println("TDS Percentage: " + String(tdsPercentage));
}

void readPH() {
  float voltage = analogRead(PH_PIN) * 5.0 / 1024;
  pHValue = phSensor.readPH(voltage, temperature);
  pHPercentage = map(pHValue, MIN_PH, MAX_PH, 0, 100);
  pHPercentage = constrain(pHPercentage, 0, 100);
  Serial.println("pH: " + String(pHValue));
  Serial.println("pH Percentage: " + String(pHPercentage));
}

void readTurbidity() {
  int turbidity = analogRead(TURBIDITY_SENSOR_PIN);
  turbidityPercentage = map(turbidity, MIN_TURBIDITY, MAX_TURBIDITY, 0, 100);
  turbidityPercentage = constrain(turbidityPercentage, 0, 100);
  Serial.println("Turbidity: " + String(turbidity));
  Serial.println("Turbidity Percentage: " + String(turbidityPercentage));
}

