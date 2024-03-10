#include <DallasTemperature.h>
#include <MQ135.h>

void readTemperatureData() {
  float temperature = Firebase.getFloat("Sensors/Temperature");
  Serial.print("Read Temperature: ");
  Serial.println(temperature);
}

void readGasAmoniaData() {
  float ppm = Firebase.getFloat("Sensors/GasAmonia");
  Serial.print("Read Gas Amonia (ppm): ");
  Serial.println(ppm);
}
