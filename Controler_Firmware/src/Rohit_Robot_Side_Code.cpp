#include <ros.h>
#include <geometry_msgs/Twist.h>

#include <AccelStepper.h>
#include <MultiStepper.h>

ros::NodeHandle  nh;
AccelStepper rot_stepper(AccelStepper::DRIVER, 3, 4);
AccelStepper lin_stepper(AccelStepper::DRIVER, 8, 9);


MultiStepper steppers;

int rot_max_speed = 500;
int lin_max_speed = 300;

int angular_steps;
int linear_steps;

long positions[2];


void messageCb( const geometry_msgs::Twist& step_data){

  angular_steps = step_data.angular.x;
  linear_steps  = step_data.linear.x;  
}

ros::Subscriber <geometry_msgs::Twist> sub("/stepper_steps", &messageCb );

void setup()
{ 

  nh.initNode();
  nh.subscribe(sub);

  rot_stepper.setPinsInverted(false, false, false);
  lin_stepper.setPinsInverted(true, false, false);
  
  rot_stepper.setMaxSpeed(rot_max_speed);
  lin_stepper.setMaxSpeed(lin_max_speed);
  lin_stepper.setAcceleration(100);

  steppers.addStepper(rot_stepper);
  steppers.addStepper(lin_stepper);
}

void loop()
{  
    
    
    positions[0] = angular_steps;
    positions[1] = linear_steps;

    steppers.moveTo(positions);
    steppers.runSpeedToPosition();
 
  nh.spinOnce();
  delay(1);
}
