#ifndef MESSAGE_HANDLER_H_
#define MESSAGE_HANDLER_H_

#include <SimpleFOC.h>

    void sendMovement(MagneticSensorI2C, MagneticSensorI2C);
    float angleToLinear(float);
    void handelMessage(USBSerial, BLDCMotor ROT_MOTOR, BLDCMotor LIN_MOTOR);
    float forceToLinVoltage(float);
    float forceToRotVoltage(float);
    void calibrationRotine(BLDCMotor, float);

#endif // MESSAGE_HANDLER_H
