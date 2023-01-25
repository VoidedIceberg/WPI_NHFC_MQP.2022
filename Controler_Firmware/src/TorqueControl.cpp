#include <Wire.h>
#include <SimpleFOC.h>
#include <utils.h>

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
// std_msgs::String lin_msg, rot_msg;
// ros::Publisher linearPub("/linear_pub", &lin_msg);
// ros::Publisher rotPub("/rotation_pub", &rot_msg);

// motor msg just for testing if ros works
std_msgs::String msg;
ros::Publisher pub("/motor_pub", &msg);

#define SENSORPWM1 PB13
#define LEDPIN PA7

#define SLAVEADDRESS 0x8
#define SDAPIN PB9
#define SCLPIN PB8

BLDCMotor motor = BLDCMotor(7, 5.6);
BLDCDriver3PWM driver = BLDCDriver3PWM(PA0, PA1, PA2, PC14);

MagneticSensorI2C sensor = MagneticSensorI2C(AS5600_I2C);

void tCinitI2C()
{
    Wire.setSDA(SDAPIN);
    Wire.setSCL(SCLPIN);
    Wire.begin(SLAVEADDRESS);
}

void tCsetup()
{
    Serial.begin(9600);
    blink(1, 200);

    // Initialize ROS
    nh.initNode();
    nh.advertise(pub);

    tCinitI2C();
    sensor.init();
    motor.linkSensor(&sensor);

    driver.voltage_power_supply = 8.4;
    driver.init();
    motor.linkDriver(&driver);
    motor.voltage_sensor_align = 5.0;

    motor.torque_controller = TorqueControlType::voltage;
    motor.controller = MotionControlType::torque;
    motor.useMonitoring(Serial);
    motor.init();
    // align sensor and start FOC
    motor.initFOC();
    motor.target = 0.5; // Volts
}

// reading directly from motor
float read(){
    float motorValue = motor.target;
    return motorValue;
}

// ask publisher to publish the topic
void publish(){
  float data = read();
  char d[] = {(char)(data)};
  msg.data = d;
  pub.publish(&msg);
}

void tCloop()
{
    // put your main code here, to run repeatedly:
    // main FOC algorithm function
    motor.loopFOC();
    Serial.print(sensor.getAngle());
    Serial.print("\t");
    Serial.println(sensor.getVelocity());
    // Motion control function
    motor.move();
    // nh.spinOnce();
}
