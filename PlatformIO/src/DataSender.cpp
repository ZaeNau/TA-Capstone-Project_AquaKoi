#include <DallasTemperature.h>
#include <MQ135.h>

#define ONE_WIRE_BUS 2
#define MQ135_Pin 35

OneWire oneWire(ONE_WIRE_BUS);
DallasTemperature sensors(&oneWire);
MQ135 gasSensor(MQ135_Pin);

void sendTemperatureData() {
  sensors.requestTemperatures();
  float temperature = sensors.getTempCByIndex(0);
  Serial.print("Temperature: ");
  Serial.println(temperature);

  if (Firebase.RTDB.setFloat("Sensors/Temperature", temperature)) {
    Serial.println("Temperature data sent to Firebase");
  } else {
    Serial.println("Failed to send temperature data");
    Serial.println("REASON: " + Firebase.errorReason());
  }
}

void sendGasAmoniaData() {
  int gasQuality = analogRead(MQ135_Pin);
  float ppm = gasQuality * (5.0 / 1023.0); 
  Serial.print("Gas Amonia (ppm): ");
  Serial.println(ppm);

  if (Firebase.RTDB.setFloat("Sensors/GasAmonia", ppm)) {
    Serial.println("Gas ammonia data sent to Firebase");
  } else {
    Serial.println("Failed to send gas ammonia data");
    Serial.println("REASON: " + Firebase.errorReason());
  }
}
