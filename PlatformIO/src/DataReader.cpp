#include <Firebase_ESP_Client.h>
#include <DallasTemperature.h>
#include <MQ135.h>

void readTemperatureData(FirebaseData &fbdo) {
  if (fbdo.getFloat("Sensors/Temperature")) {
    Serial.print("Read Temperature: ");
    Serial.println(fbdo.floatData());
  } else {
    Serial.println("Failed to read temperature data");
    Serial.println("REASON: " + fbdo.errorReason());
  }
}

void readGasAmoniaData(FirebaseData &fbdo) {
  if (fbdo.getFloat("Sensors/GasAmonia")) {
    Serial.print("Read Gas Amonia (ppm): ");
    Serial.println(fbdo.floatData());
  } else {
    Serial.println("Failed to read gas ammonia data");
    Serial.println("REASON: " + fbdo.errorReason());
  }
}