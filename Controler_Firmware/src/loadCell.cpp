#include <loadCell.h>
#include <SimpleFOC.h>
#include <arduino.h>
#include "HX711.h"
#include <main.h>
#include <utils.h>

float calValue = 1.0;

HX711 scale;

void initLoadCell()
{
    scale.begin(I2C_SDA_PIN, I2C_SCL_PIN);
}

void calibrateLinear(BLDCMotor *LIN_MOTOR)
{
    Serial.println("Calibrating linear axis");
    TCA9548A(7);
    initLoadCell();
    Serial.println("The load cell currently reads:" + String(readLoadCell()));

    float testVoltage = 0.0;
    while (testVoltage <= 2.0)
    {
        TCA9548A(0);
        LIN_MOTOR->target = testVoltage;
        LIN_MOTOR->loopFOC();
        LIN_MOTOR->move();

        TCA9548A(7);
        Serial.println(String(testVoltage) + " " + String(readLoadCell()));
        testVoltage += 0.01;
    }
}

float readLoadCell()
{
    Serial.println("Reading load cell");
    TCA9548A(7);
    return scale.read();
}