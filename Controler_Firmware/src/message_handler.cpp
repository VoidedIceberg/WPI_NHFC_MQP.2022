#include <message_handler.h>
#include <SimpleFOC.h>

float lastROTAngle = 0.0;
float lastLinAngle = 0.0;

// Function to send the movement to the PC host
// Only sends the distance traveled since the last send
void sendMovement(MagneticSensorI2C ROT_ENCODER, MagneticSensorI2C LIN_ENCODER)
{
    ROT_ENCODER.update();
    LIN_ENCODER.update();
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
    // this equation was taken from the leaver arm and assumes the force in grams
    float voltage = (-0.0017 * (force*force) + 0.3953*force -1.7699) / 1.0; // needs a conversion factor to even make since
    if (voltage >= 0.0 || voltage < 1.2)
    {
        return voltage;
    }
    else
    {
        Serial.print("Lin Voltage calculated out of range!!!   -");
        Serial.println(voltage);
        return 0;
    }
}

// Function to convert the rotational force to a voltage, this will be found by calibration
float forceToRotVoltage(float force)
{
    // this equation was taken from the leaver arm and assumes the force in grams
    float voltage = (-0.0017 * (force * force) + 0.3953 * force - 1.7699) / 1.0; // needs a conversion factor to even make since
    if (voltage >= 0.0 || voltage < 1.2)
    {
        return voltage;
    }
    else
    {
        Serial.print("Rot Voltage calculated out of range!!!   -");
        Serial.println(voltage);
        return 0;
    }
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
            LIN_MOTOR.move();
            ROT_MOTOR.move();
        } else if (message[0] == 'R')
        {
            int motor = -1;
            float nextTargetV = 0.0;
            sscanf(message, "F %d %f", &motor, &nextTargetV);
            if (motor > -1)
            {
                switch (motor)
                {
                case 0: // rot motor
                    calibrationRotine(ROT_MOTOR, nextTargetV);
                    break;
                case 1:
                    calibrationRotine(LIN_MOTOR, nextTargetV);
                    break;
                default:
                    Serial.println("What motor?");
                    break;
                }
            }
            else
            {
                Serial.println("Please format in: 'R {motor 0:Rot 1:lin} {optional: targetV}");
            }
        }
    }
}
float voltageTesting = 0.0;

void calibrationRotine(BLDCMotor motor, float targetV)
{
    if (targetV > 0.0)
    {
        voltageTesting = targetV;
    }
    else
    {
        voltageTesting += 0.01;
    }
    motor.target = voltageTesting;
    motor.move();
    Serial.print("T ");
    Serial.print(voltageTesting);
}
