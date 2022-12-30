#ifndef MESSAGE_HANDLER_H_
#define MESSAGE_HANDLER_H_

#include <SimpleFOC.h>

void sendMovement(MagneticSensorI2C, MagneticSensorI2C);
float angleToLinear(float);
void handelMessage(USBSerial);
float forceToLinVoltage(float);
float forceToRotVoltage(float);

#endif // MESSAGE_HANDLER_H
