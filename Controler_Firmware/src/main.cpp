#include <Arduino.h>
#include <SimpleFOC.h>
#include <main.h>
#include <message_handler.h>
#include <utils.h>
#include <hardwareTesting.h>

//include ROS package
#include <ros.h>
#include <std_msgs/String.h>
#include <string.h>

// DM:PA11  DP:PA12
// setup the harware serial1
HardwareSerial Serial1(PA_11, PA_12);

// init a node handler
ros::NodeHandle nh;

// create linearPublisher and rotationPublisher
std_msgs::String lin_msg, rot_msg;
ros::Publisher linearPub("/linear_pub", &lin_msg);
ros::Publisher rotPub("/rotation_pub", &rot_msg);

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

  Serial1.begin(9600); // initialize serial communication on the CDC USB port
  initI2C();
  initMotor(ROT_MOTOR, ROT_DRIVER, ROT_ENCODER);
  initMotor(LIN_MOTOR, LIN_DRIVER, LIN_ENCODER);

  // Initialize ROS
  nh.initNode();
  nh.advertise(linearPub);
  nh.advertise(rotPub);

  LIN_MOTOR.target = 0;
  ROT_MOTOR.target = 0;
}

// reading directly from motor
float read(){
    float linear = LIN_MOTOR.target;
    float rot = ROT_MOTOR.target;
    return linear, rot;
}

// ask publisher to publish the topic
void publish(){
  float linear, rot = read();
  char l[] = {(char)(linear)};
  char r[] = {(char)(rot)};
  lin_msg.data = l;
  rot_msg.data = r;
  linearPub.publish(&lin_msg);
  rotPub.publish(&rot_msg);
}

void loop()
{
  switch (state)
  {
  case IDLE:
    state = READING;
    break;
  case READING:
    if (Serial1.available() > 0)
    {
      handelMessage(Serial, ROT_MOTOR, LIN_MOTOR);
    }
    state = SENDING;
    break;
  case SENDING:
    // sendMovement(ROT_ENCODER, LIN_ENCODER);
    state = READING;
    break;
    
  default:
    state = IDLE;
    break;
  }

  // Makes sure the motors run on every loop
  LIN_MOTOR.loopFOC();
  ROT_MOTOR.loopFOC();
  // printf("%f", LIN_MOTOR.target);
  // delay(1000);
  blink(1, 0);

  // system running
  nh.spinOnce();
  publish();
}

void initMotor(BLDCMotor motor, BLDCDriver3PWM driver, MagneticSensorI2C encoder)
{
  encoder.init();
  driver.init();
  driver.voltage_power_supply = VCC;
  motor.voltage_limit = VOLTAGE_LIMIT;
  motor.velocity_limit = VELOCITY_LIMIT;
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
