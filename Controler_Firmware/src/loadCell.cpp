#include <loadCell.h>
#include <SimpleFOC.h>
#include <arduino.h>
#include "HX711.h"
#include <main.h>
#include <utils.h>


float calValue = 1.0;

// HX711 scale;

void initLoadCell()
{
}

void calibrateLinear(BLDCMotor *LIN_MOTOR)
{
    Serial.println("Calibrating Linear axis");

    float testVoltage = 0.0;
    while (testVoltage <= 1.5)
    {
        TCA9548A(0);
        LIN_MOTOR->target = testVoltage;
        LIN_MOTOR->loopFOC();
        LIN_MOTOR->move();

        Serial.println(String(testVoltage) + " " + String(readLoadCell(2)));
        testVoltage += 0.01;
    }
}

void calibrateRot(BLDCMotor *ROT_MOTOR)
{
    Serial.println("Calibrating rotational axis");

    float testVoltage = 0.0;
    while (testVoltage <= 1.5)
    {
        TCA9548A(1);
        ROT_MOTOR->target = testVoltage;
        ROT_MOTOR->loopFOC();
        ROT_MOTOR->move();

        Serial.println(String(testVoltage) + " " + String(readLoadCell(7)));
        testVoltage += 0.01;
    }
}

float readLoadCell(int ch)
{
    TCA9548A(ch);
    Wire.end();
    HX711 s;
    s.begin(I2C_SDA_PIN, I2C_SCL_PIN);
    s.wait_ready();
    if (ch == 2)
    {
        // cal factor = 81582 / 16.0 = 5098.625
        s.set_scale(5098.625);
    }
    if (ch == 7)
    {
        // cal factor = 169857.00 / 16.0 = 10604.1875
        s.set_scale(10604.1875);
    }

    float reading = s.get_units(10);
    Wire.begin();
    return reading;
}