#include <loadCell.h>
#include <arduino.h>
#include "HX711.h"
#include <main.h>

float calValue = 1.0;

HX711 scale;

void initLoadCell()
{
    scale.begin(I2C_SDA_PIN, I2C_SCL_PIN);
}

void calibrate()
{
    while (1)
    {
        break;
    }
}

float readLoadCell()
{
    return scale.read();
}