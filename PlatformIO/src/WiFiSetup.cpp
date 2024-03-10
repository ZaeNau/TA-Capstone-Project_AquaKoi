#include <WiFi.h>

#define WIFI_SSID "Kos34D_Lt2_plus"
#define WIFI_PASSWORD "Eric2010"

void setupWiFi() {
  // The process of connecting the WiFi on the ESP32 to the WiFi.
  WiFi.mode(WIFI_STA);
  WiFi.begin(WIFI_SSID, WIFI_PASSWORD);
  Serial.println("---------------Connection");
  Serial.print("Connecting to : ");
  Serial.println(WIFI_SSID);
  while (WiFi.status() != WL_CONNECTED){
    Serial.print(".");
    delay(500);
  }
  Serial.println();
  Serial.print("Successfully connected to : ");
  Serial.println(WIFI_SSID);
  Serial.println("---------------");
}
