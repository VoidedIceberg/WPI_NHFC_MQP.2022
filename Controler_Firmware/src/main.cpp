#include <Arduino.h>
#include <SimpleFOC.h>

enum STATE
{
  INIT,    // When the controller is first powered on
  IDLE,    // When waiting for the PC host to connect
  READING, // Checks for new messages from the PC host
  ACTING,  // Commands the forces acting on linear and rotational axis
  SENDING, // Sends the change in position to the PC host
};

void initI2C(void);
void blink(int amount, int del);
void initMotor(BLDCMotor motor, BLDCDriver3PWM driver, MagneticSensorI2C encoder);

enum STATE state = INIT;

#define LEDPIN PA7

#define MOTOR_POLES 7
#define MOTOR_RESISTANCE 5.6

BLDCMotor ROT_MOTOR = BLDCMotor(MOTOR_POLES, MOTOR_RESISTANCE);
BLDCDriver3PWM ROT_DRIVER = BLDCDriver3PWM(PC0, PC1, PC2, PC13); // M1 Port
MagneticSensorI2C ROT_ENCODER = MagneticSensorI2C(AS5600_I2C);

BLDCMotor LIN_MOTOR = BLDCMotor(MOTOR_POLES, MOTOR_RESISTANCE);
BLDCDriver3PWM LIN_DRIVER = BLDCDriver3PWM(PA0, PA1, PA2, PC14); // M2 Port
MagneticSensorI2C LIN_ENCODER = MagneticSensorI2C(AS5600_I2C);

#define I2C_SDA_PIN PB9
#define I2C_SCL_PIN PB8
#define SLAVEADDRESS 0x8

#define FEED_BUTTON_PIN ;

void setup()
{
  // put your setup code here, to run once:
  Serial.begin(9600);
  initI2C();
  initMotor(ROT_MOTOR, ROT_DRIVER, ROT_ENCODER);
  initMotor(LIN_MOTOR, LIN_DRIVER, LIN_ENCODER);

  LIN_MOTOR.target = 0;
  ROT_MOTOR.target = 0;
}

void initMotor(BLDCMotor motor, BLDCDriver3PWM driver, MagneticSensorI2C encoder)
{
  encoder.init();
  driver.init();
  driver.voltage_power_supply = 8.4;
  motor.voltage_limit = 1.4;
  motor.velocity_limit = 3;
  motor.linkDriver(&driver);
  motor.linkSensor(&encoder);
  motor.torque_controller = TorqueControlType::voltage;
  motor.controller = MotionControlType::torque;
  motor.useMonitoring(Serial);
  motor.init();
  motor.initFOC();
  motor.target = 0;
}

void initI2C()
{
  Wire.setSDA(I2C_SDA_PIN);
  Wire.setSCL(I2C_SCL_PIN);
  Wire.begin(SLAVEADDRESS);
}

void loop()
{
  switch (state)
  {
    case INIT:
      break;
    case IDLE:
      break;
    case READING:
      break;
    case ACTING:
      break;
    case SENDING:
      break;
    default:
      break;
  }
  
  // Makes sure the motors run on every loop
  LIN_MOTOR.loopFOC();
  ROT_MOTOR.loopFOC();

  LIN_MOTOR.move();
  ROT_MOTOR.move();
}

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