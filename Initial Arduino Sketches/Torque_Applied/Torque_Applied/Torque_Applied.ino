#include <Wire.h>
#include <SimpleFOC.h>
#include <SoftwareSerial.h>

SoftwareSerial Serial11(PC11, PC10); // Rx, Tx

#define SENSORPWM1 PB13
#define LEDPIN PA7

#define SLAVEADDRESS 0x8
#define SDAPIN PB9 // CN11 pin 1
#define SCLPIN PB8 // CN10 pin 1

BLDCMotor motor = BLDCMotor(7, 5.6);
BLDCDriver3PWM driver = BLDCDriver3PWM(PA0, PA1, PA2, PC14);

MagneticSensorI2C sensor = MagneticSensorI2C(AS5600_I2C); 

float V = 1.0; // Volts

void initI2C() {
  Wire.setSDA(SDAPIN);
  Wire.setSCL(SCLPIN);
  Wire.begin(SLAVEADDRESS);
}

void setup() {
  Serial.begin(9600);
  Serial11.begin(9600);

  Wire.begin();        // join i2c bus (address optional for master)
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
  
union u_tag {
    byte b[4];
    float fval;
} u;

int i = 0;
union u_tag read;

void loop() { 
  // this is the secion that handels data coming in from the serail11 port (from esp8266)
  if (Serial11.available() > 0){
      byte r = Serial11.read();
      read.b[i] = r;
      i++;
  }
  if (i == 4)
  {
    V = read.fval;
    motor.target = V;

    read.fval = 0.0;
    i = 0;
  }
  
  Serial.print(V);
  Serial.print("\t");
  Serial.println(sensor.getAngle());
  
  motor.loopFOC();
  motor.move();
}
