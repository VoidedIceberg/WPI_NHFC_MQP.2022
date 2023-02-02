#ifndef UTILS_H_
#define UTILS_H_

#include <SimpleFOC.h>

void blink(int amount, int del);
float calculateFakeForces(MagneticSensorI2C);
void TCA9548A(uint8_t bus);
float readLINencoder(MagneticSensorI2C sensor);
float readROTencoder(MagneticSensorI2C sensor);

#endif // UTILS_H_
