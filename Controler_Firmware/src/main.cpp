#include <Arduino.h>
#include <SimpleFOC.h>
#include <main.h>
#include <message_handler.h>
#include <utils.h>

BLDCMotor ROT_MOTOR = BLDCMotor(MOTOR_POLES, MOTOR_RESISTANCE);
BLDCDriver3PWM ROT_DRIVER = BLDCDriver3PWM(PC0, PC1, PC2, PC13); // M1 Port
MagneticSensorI2C ROT_ENCODER = MagneticSensorI2C(AS5600_I2C);

BLDCMotor LIN_MOTOR = BLDCMotor(MOTOR_POLES, MOTOR_RESISTANCE);
BLDCDriver3PWM LIN_DRIVER = BLDCDriver3PWM(PA0, PA1, PA2, PC14); // M2 Port
MagneticSensorI2C LIN_ENCODER = MagneticSensorI2C(AS5600_I2C);

enum STATE state = IDLE;

void setup()
{
  // put your setup code here, to run once:

  Serial.begin(9600); // initialize serial communication on the CDC USB port
  initI2C();
  initMotor(&ROT_MOTOR,1, &ROT_DRIVER, &ROT_ENCODER);
  initMotor(&LIN_MOTOR,0, &LIN_DRIVER, &LIN_ENCODER);

  LIN_MOTOR.target = 0;
  ROT_MOTOR.target = 0;
}

void loop()
{
  switch (state)
  {
  case IDLE:
    state = READING;
    break;
  case READING:
    if (Serial.available() > 0)
    {
      handelMessage(Serial, &ROT_MOTOR, &LIN_MOTOR);
    }
    state = SENDING;
    break;
  case SENDING:
    sendMovement(ROT_ENCODER, LIN_ENCODER);
    state = READING;
    break;
  default:
    state = IDLE;
    break;
  }
  // // Makes sure the motors run on every loop
  TCA9548A(1);
  ROT_ENCODER.update();
  ROT_MOTOR.loopFOC();
  ROT_MOTOR.move();

  TCA9548A(0);
  LIN_ENCODER.update();
  LIN_MOTOR.loopFOC();
  LIN_MOTOR.move();

  blink(1, 0);
}

void initMotor(BLDCMotor* motor,int MUX_CHANNEL,  BLDCDriver3PWM* driver, MagneticSensorI2C* encoder)
{
  TCA9548A(MUX_CHANNEL); // makes sure it switches into the right channel for initilization
  encoder->init();
  motor->linkSensor(encoder);

  driver->voltage_power_supply = VCC;
  driver->init();
  motor->linkDriver(driver);
  motor->voltage_sensor_align = 5.0;
  motor->torque_controller = TorqueControlType::voltage;
  motor->controller = MotionControlType::torque;

  // motor.voltage_limit = VOLTAGE_LIMIT;
  // motor.velocity_limit = VELOCITY_LIMIT;
  motor->useMonitoring(Serial);
  motor->init();
  TCA9548A(MUX_CHANNEL); // makes sure it switches into the right channel for initilization
  motor->initFOC();
  motor->target = 0.0;
}

void initI2C()
{
  Wire.setSDA(I2C_SDA_PIN);
  Wire.setSCL(I2C_SCL_PIN);
  Wire.begin(SLAVEADDRESS);
}


