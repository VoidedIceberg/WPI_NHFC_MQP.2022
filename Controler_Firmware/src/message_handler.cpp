#include <message_handler.h>
#include <SimpleFOC.h>

void function()
{
    int x = 0;
    for (int i = 0; i < 10; i++)
    {
        x += i;
    }
}

float lastROTAngle = 0.0;
float lastLinAngle = 0.0;

// Function to send the movement to the PC host
// Only sends the distance traveled since the last send
void sendMovement(MagneticSensorI2C ROT_ENCODER, MagneticSensorI2C LIN_ENCODER)
{
    float currentRotAngle = ROT_ENCODER.getAngle();
    float currentLinAngle = LIN_ENCODER.getAngle();

    // Send the movement to the PC host
    Serial.print("M ");
    Serial.print(currentRotAngle - lastROTAngle);
    Serial.print(" ");
    Serial.println(angleToLinear(currentLinAngle - lastLinAngle));

    lastROTAngle = currentRotAngle;
    lastLinAngle = currentLinAngle;
}

// Function to convert the angle to a linear measurement
float angleToLinear(float angle)
{
    int diameter = 20 ; // mm
    return angle * 3.14 * diameter;
}

// Function to convert the linear force to a voltage, this will be found by calibration
float forceToLinVoltage(float force)
{
    return force;
}

// Function to convert the rotational force to a voltage, this will be found by calibration
float forceToRotVoltage(float force)
{
    return force;
}

// Function handels incomming message on the serial port and sets the motors target accordingly
void handelMessage(USBSerial serial, BLDCMotor ROT_MOTOR, BLDCMotor LIN_MOTOR)
{
    // Check if there is a message from the PC host
    if (serial.available())
    {
        // Read the message
        char message[10];
        serial.readBytes(message, 10);

        // Check if the message is a movement command
        if (message[0] == 'F')
        {
            // Read the movement command
            float rot = 0.0;
            float lin = 0.0;
            sscanf(message, "F %f %f", &rot, &lin);

            // Set the target for the motors
            ROT_MOTOR.target = forceToRotVoltage(rot);
            LIN_MOTOR.target = forceToLinVoltage(lin);
        }
    }
}
