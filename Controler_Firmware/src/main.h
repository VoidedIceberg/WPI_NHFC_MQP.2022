#ifndef MAIN_H_
#define MAIN_H_

#include <SimpleFOC.h>

#define LEDPIN PA7
#define FEED_BUTTON_PIN PA0

#define MOTOR_POLES 7
#define MOTOR_RESISTANCE 5.6

#define I2C_SDA_PIN PB9
#define I2C_SCL_PIN PB8
#define SLAVEADDRESS 0x8

enum STATE
{
    IDLE,    // When waiting for the PC host to connect
    READING, // Checks for new messages from the PC host
    ACTING,  // Commands the forces acting on linear and rotational axis
    SENDING  // Sends the change in position to the PC host
};

void initI2C(void);
void initMotor(BLDCMotor motor, BLDCDriver3PWM driver, MagneticSensorI2C encoder);

#endif // MAIN_H_
