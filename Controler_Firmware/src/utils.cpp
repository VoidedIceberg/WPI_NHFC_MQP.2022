#include <Arduino.h>
#include <main.h>
#include <utils.h>

void blink(int amount, int del)
{
    pinMode(LEDPIN, OUTPUT);

    for (int i = 0; i < amount; i++)
    {
        digitalWrite(LEDPIN, HIGH);
        delay(del);
        digitalWrite(LEDPIN, LOW);
        delay(del);
    }
}

float calculateFakeForces(MagneticSensorI2C sensor)
{  
    float angle = sensor.getAngle();
    float velocity = sensor.getVelocity();   

    return 0.0;
}

void TCA9548A(uint8_t bus)
{
    Wire.beginTransmission(0x70);
    Wire.write(1 << bus);
    Wire.endTransmission();
}

float readLINencoder(MagneticSensorI2C sensor)
{
  TCA9548A(0);
  sensor.update();
  return sensor.getAngle();
}

float readROTencoder(MagneticSensorI2C sensor)
{
  TCA9548A(1);
  sensor.update();
  return sensor.getAngle();
}

