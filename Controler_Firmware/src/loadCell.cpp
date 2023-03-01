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
    // Serial.println("Calibrating linear axis");
    // TCA9548A(7);
    // initLoadCell();
    // Serial.println("The load cell currently reads:" + String(readLoadCell(2)));

    // float testVoltage = 0.0;
    // while (testVoltage <= 2.0)
    // {
    //     TCA9548A(0);
    //     LIN_MOTOR->target = testVoltage;
    //     LIN_MOTOR->loopFOC();
    //     LIN_MOTOR->move();

    //     TCA9548A(7);
    //     Serial.println(String(testVoltage) + " " + String(readLoadCell(2)));
    //     testVoltage += 0.01;
    // }
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

    float reading = s.get_units(5);
    Wire.begin();
    return reading;
}