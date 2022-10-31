#include <Wire.h>
#include <SimpleFOC.h>


#define SENSORPWM1 PB13
#define LEDPIN PA7

#define SLAVEADDRESS 0x8
#define SDAPIN PB9
#define SCLPIN PB8

BLDCMotor motor = BLDCMotor(7, 5.6);
BLDCDriver3PWM driver = BLDCDriver3PWM(PA0, PA1, PA2, PC14);

MagneticSensorI2C sensor = MagneticSensorI2C(AS5600_I2C); 

// we want to change it continuously
float V = 1.0; // Volts

void initI2C() {
  Wire.setSDA(SDAPIN);
  Wire.setSCL(SCLPIN);
  Wire.begin(SLAVEADDRESS);
}

void parseInput(float input){
  V = input;
}

void checkVoltage(){
  if(V>8.4){
    V = 8.4;
  }
  if(V<=0.0){
    V = 0;
  }
}

void setup() {
  Serial.begin(9600);
  initI2C();
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
  motor.target = V;
}

void loop() {
  checkVoltage();
  float input = Serial.parseFloat();
  if(input != 0.0 && input <= 8.4){
      parseInput(input);
  }
  Serial.print("Voltage: ");
  Serial.println(V);
  // put your main code here, to run repeatedly:
  // main FOC algorithm function
  motor.loopFOC();
  // Serial.print(sensor.getAngle());
  // Serial.print("\t");
  // Serial.println(sensor.getVelocity());
  // Motion control function
  motor.move();
}
