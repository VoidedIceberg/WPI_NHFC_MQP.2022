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
