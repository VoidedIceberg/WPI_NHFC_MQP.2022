All Needed Commands for Running Test on Interventional Robotic Platform:

For all terminals:

source ~/robotic_intervention_ws/devel/setup.bash


1- Terminal 1:
source ~/robotic_intervention_ws/devel/setup.bash
roslaunch polhemus_ros_driver start.launch

2- Terminal 2:
source ~/robotic_intervention_ws/devel/setup.bash
rosrun rinterventional_platform bench_motion.py


3- Terminal 3:
source ~/robotic_intervention_ws/devel/setup.bash
rosrun rosserial_python serial_node.py /dev/ttyACM0

4- Terminal 4:
source ~/robotic_intervention_ws/devel/setup.bash
rosrun rviz rviz

5- Terminal 5:
source ~/robotic_intervention_ws/devel/setup.bash
rostopic echo /tf


6- Terminal 6:
source ~/robotic_intervention_ws/devel/setup.bash
rostopic echo /Step_Generator