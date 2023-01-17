# generated from catkin/cmake/template/pkg.context.pc.in
CATKIN_PACKAGE_PREFIX = ""
PROJECT_PKG_CONFIG_INCLUDE_DIRS = "${prefix}/include".split(';') if "${prefix}/include" != "" else []
PROJECT_CATKIN_DEPENDS = "actionlib_msgs;geometry_msgs;nav_msgs;rospy;roscpp;sensor_msgs;std_msgs;trajectory_msgs;visualization_msgs;message_runtime;rospy".replace(';', ' ')
PKG_CONFIG_LIBRARIES_WITH_PREFIX = "-lcustom_msg_srv_package".split(';') if "-lcustom_msg_srv_package" != "" else []
PROJECT_NAME = "custom_msg_srv_package"
PROJECT_SPACE_DIR = "/home/rohit/robotic_intervention_ws/install"
PROJECT_VERSION = "0.0.0"
