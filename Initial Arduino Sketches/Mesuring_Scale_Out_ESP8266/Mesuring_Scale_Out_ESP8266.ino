/**
 * Complete project details at https://RandomNerdTutorials.com/esp8266-load-cell-hx711/
 * 
 * HX711 library for Arduino - example file
 * https://github.com/bogde/HX711
 *
 * MIT License
 * (c) 2018 Bogdan Necula
 *
**/

#include <Arduino.h>
#include "HX711.h"
#include <Wire.h>
#include <SoftwareSerial.h>

SoftwareSerial Serial2(D7, D8); // RX, TX

// HX711 circuit wiring
const int LOADCELL_DOUT_PIN = D2;
const int LOADCELL_SCK_PIN = D3;

HX711 scale;


typedef union {
  float fp;
  byte bin[4];
} bF;

bF requested_V;

void setup() {
  Serial.begin(115200);
  Serial2.begin(9600);
  requested_V.fp = 0.0f;
  
  Wire.begin();  
  Serial.println("Initializing the scale");

  scale.begin(LOADCELL_DOUT_PIN, LOADCELL_SCK_PIN);

  scale.set_scale(11936 / 12); // 11936 / 12
  scale.tare();               // reset the scale to 0

  Serial.println("Readings:");
}

void readScale()
{
   Serial.print(requested_V.fp);
   Serial.print("\t");
   Serial.println(scale.get_units());
}

float last = 0;

void loop() {
  if (millis()-last > 10000) // This makes it happen every 10 sec.
  {
    requested_V.fp = requested_V.fp + 0.01;
    Serial2.write(requested_V.bin,4);

    last = millis();
  }
  readScale();

}
