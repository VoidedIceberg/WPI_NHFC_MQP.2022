#include <ros.h>
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

void setup()
{
  x = 0;
  y = 0;
  z = 0;
  Serial.begin(9600);
  Serial.println("HELLO I'M HERE");
  nh.initNode();
  nh.subscribe(sub);
}

void loop()
{
  Serial.println(x);
  nh.spinOnce();
  delay(1);
}