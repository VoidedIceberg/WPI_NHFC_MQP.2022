#include <ros.h>
#include <std_msgs/String.h>
#include <geometry_msgs/WrenchStamped.h>

float x;
float y;
float z;

void testMSG( const geometry_msgs::WrenchStamped& force_data){
  x = force_data.wrench.force.x;
  y = force_data.wrench.force.y;
  z = force_data.wrench.force.z;
}

ros::NodeHandle nh;
ros::Subscriber <geometry_msgs::WrenchStamped> sub("/ft_data", &testMSG );

std_msgs::String str_msg;
ros::Publisher chatter("/chatter", &str_msg);
char check[11] = "I got msg!";

void setup()
{
  x = 0;
  y = 0;
  z = 0;
  Serial.begin(115200);
  Serial.println("HELLO I'M HERE");
  nh.initNode();
  nh.advertise(chatter);
  nh.subscribe(sub);
}

void loop()
{
  str_msg.data = check;
  chatter.publish(&str_msg);
  nh.spinOnce();
  delay(1);
}

/*
 * rosserial Subscriber Example
 * Blinks an LED on callback
*/

// #include <ros.h>
// #include <std_msgs/Empty.h>

// ros::NodeHandle nh;

// void messageCb( const std_msgs::Empty& msg){
//     digitalWrite(9, HIGH); 
// }
 
// ros::Subscriber<std_msgs::Empty> sub("toggle_led", &messageCb );

// void setup()
// {
//   pinMode(9, OUTPUT);
//   nh.initNode();
//   nh.subscribe(sub);
// }

// void loop()
// {
//   nh.spinOnce();
//   digitalWrite(9, LOW);
//   delay(1);
// }