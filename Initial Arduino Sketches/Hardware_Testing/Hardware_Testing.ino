#include <Wire.h>
#include <SimpleFOC.h>

/*
   Rotary Encoder Wires:
   Purple - PWM -  Gray
   Green  - GND -  Black
   Blue   - 5V  -  White
*/

#define SENSORPWM1 PB13
#define LEDPIN PA7

#define SLAVEADDRESS 0x8
#define SDAPIN PB9
#define SCLPIN PB8

BLDCMotor motor = BLDCMotor(7, 5.6);
BLDCDriver3PWM driver = BLDCDriver3PWM(PA0, PA1, PA2, PC14);

MagneticSensorI2C sensor = MagneticSensorI2C(AS5600_I2C);

void blink(int amount, int del)
{
  pinMode(LEDPIN, OUTPUT);

  for (int i = 0; i < amount; i++)
  {
    digitalWrite(LEDPIN, HIGH);
    delay(del);
    digitalWrite(LEDPIN, LOW);
    delay(del);
  }
}

void initI2C()
{
  Wire.setSDA(SDAPIN);
  Wire.setSCL(SCLPIN);
  Wire.begin(SLAVEADDRESS);
}

void setup()
{
   // monitoring port
   Serial.begin(9600);

   initI2C();
   // initialise encoder hardware
   sensor.init();

   // driver config
   // power supply voltage [V]
   driver.voltage_power_supply = 8.4;
   driver.init();
   // link the motor and the driver
   motor.linkDriver(&driver);

   motor.voltage_limit = 4;  // [V] - if phase resistance not defined
   motor.velocity_limit = 7; // [rad/s] cca 50rpm

   motor.controller = MotionControlType::velocity_openloop;
   motor.init();
   blink(5, 200);

   Serial.println("Motor ready!");
   Serial.println("Set target velocity [rad/s]");

   motor.target = 6.0;
   //user communication
}

void loop()
{
  blink(1, 0);
  // IMPORTANT
  // read sensor and update the internal variables
  sensor.update();
  // display the angle and the angular velocity to the terminal
  Serial.print(sensor.getAngle());
  Serial.print("\t");
  Serial.println(sensor.getVelocity());
  motor.move();
}
