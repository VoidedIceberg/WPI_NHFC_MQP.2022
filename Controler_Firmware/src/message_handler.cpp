#include <message_handler.h>
#include <main.h>
#include <SimpleFOC.h>
#include <utils.h>
#include <sstream>
#include <GCodeParser.h>
#include <loadCell.h>
#include <SoftwareSerial.h>

using namespace std;

GCodeParser GCode = GCodeParser();

float lastROTAngle = 0.0;
float lastLinAngle = 0.0;

// Function to send the movement to the PC host
// Only sends the distance traveled since the last send
void sendMovement(MagneticSensorI2C ROT_ENCODER, MagneticSensorI2C LIN_ENCODER)
{
    ROT_ENCODER.update();
    LIN_ENCODER.update();
    float currentRotAngle = readROTencoder(ROT_ENCODER);
    float currentLinAngle = readLINencoder(LIN_ENCODER);

    // Send the movement to the PC host
    Serial.print("M R");
    Serial.print(currentRotAngle);
    Serial.print(" L");
    Serial.println(angleToLinear(currentLinAngle));
}

// Function to convert the angle to a linear measurement
float angleToLinear(float angle)
{
    int diameter = 20; // mm
    return angle * 3.14 * diameter;
}

// Function to convert the linear force to a voltage, this will be found by calibration
float forceToLinVoltage(float force)
{
    // this equation was taken from the leaver arm and assumes the force in grams
    float voltage = (-0.0017 * (force * force) + 0.3953 * force - 1.7699) / 1.0; // needs a conversion factor to even make since
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
    // y = 0.0002x2 + 0.0116x R² = 0.9989
    float voltage = 0.017 * force; // needs a conversion factor to even make since

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
void handelMessage(SoftwareSerial* s, BLDCMotor *ROT_MOTOR, BLDCMotor *LIN_MOTOR)
{
    if (s->available() > 0)
    {
        if (GCode.AddCharToLine(s->read()))
        {
            GCode.ParseLine();
            // Code to process the line of G-Code here…
            GCode.RemoveCommentSeparators();

            if (GCode.HasWord('F'))
            {
                float R, L = 0.0;
                if (GCode.HasWord('R'))
                {
                    R = (float)GCode.GetWordValue('R');
                }
                if (GCode.HasWord('L'))
                {
                    L = (float)GCode.GetWordValue('L');
                }

                ROT_MOTOR->target = forceToRotVoltage(R);
                LIN_MOTOR->target = forceToLinVoltage(L);
            }
            else if (GCode.HasWord('V'))
            {
                float R, L = 0.0;
                if (GCode.HasWord('R'))
                {
                    R = (float)GCode.GetWordValue('R');
                }
                if (GCode.HasWord('L'))
                {
                    L = (float)GCode.GetWordValue('L');
                }

                ROT_MOTOR->target = (abs(R) < 2.1) ? R : 0.0;
                LIN_MOTOR->target = (abs(L) < 2.1) ? L : 0.0;
            }
            else if (GCode.HasWord('C'))
            {
                if (GCode.HasWord('L'))
                {
                    calibrateLinear(LIN_MOTOR);
                }
                else if (GCode.HasWord('R'))
                {
                    calibrateRot(ROT_MOTOR);
                }
                else if (GCode.HasWord('G'))
                {
                    while (true)
                    {
                        float controlForce = readLoadCell(2);
                        Serial.print(controlForce);
                        Serial.print(" ");
                        Serial.print(forceToRotVoltage(controlForce));
                        ROT_MOTOR->target = (forceToRotVoltage(controlForce)-0.1);
                        for (int i = 0; i < 1000; i++)
                        {
                            TCA9548A(1);
                            ROT_MOTOR->loopFOC();
                            ROT_MOTOR->move();
                        }
                        float measuredForce = readLoadCell(7);

                        Serial.print(" ");
                        Serial.println(measuredForce);
                    }
                }
                else{
                    // initI2C();
                    while (true)
                    {
                        float LC1 = readLoadCell(7);
                        float LC2 = readLoadCell(2);

                        Serial.print(LC1);
                        Serial.print(" ");
                        Serial.println(LC2);
                    }
                }
            }
            else if (GCode.HasWord('Z'))
            {
                s->println(readLoadCell(2));
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
