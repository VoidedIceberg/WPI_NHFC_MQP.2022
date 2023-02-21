#!/usr/bin/env python3

import rospy
import numpy as np
import re
import serial, serial.tools.list_ports
from geometry_msgs.msg import Vector3
from geometry_msgs.msg import WrenchStamped

class RosDataHandler:
    def __init__(self, linear_scale, angular_scale, pub_topic_name="Step_Generator", sub_topic_name="/ft_data"):

        rospy.init_node("communication_handler", anonymous=False)
        self.node_name = rospy.get_caller_id()
        self.pub_topic_name = pub_topic_name
        self.sub_topic_name = sub_topic_name

        self.linear_scale, self.angular_scale  = np.ravel((linear_scale, angular_scale))
        self.fx, self.fy, self.fz, self.tx, self.ty, self.tz = np.ravel((0, 0, 0, 0, 0, 0))

        self.pub_steps = rospy.Publisher(self.pub_topic_name, Vector3, queue_size=10)
        rospy.Subscriber(self.sub_topic_name, WrenchStamped, callback=self.extract_force_torque_data)

        self.rate = rospy.Rate(500)

        rospy.loginfo("\tRunning from %s node", self.node_name)
        rospy.loginfo("\tPublishing  to topic: %s", self.pub_topic_name)
        rospy.loginfo("\tSubscribing to topic: %s", self.sub_topic_name)

    def extract_force_torque_data(self, ft_data):
        self.fx = ft_data.wrench.force.x
        self.fy = ft_data.wrench.force.y
        self.fz = ft_data.wrench.force.z

        self.tx = ft_data.wrench.torque.x
        self.ty = ft_data.wrench.torque.y
        self.tz = ft_data.wrench.torque.z

    def set_step_scale2(self, linear_scale, angular_scale):
        self.linear_scale  = linear_scale
        self.angular_scale = angular_scale

    def publish_step_commands(self, linear_steps, angular_steps):
        step_data = Vector3()

        step_data.x = linear_steps  * self.linear_scale
        step_data.y = angular_steps * self.angular_scale
        step_data.z = 0

        self.pub_steps.publish(step_data)

    def get_latest_force_data(self):
        return self.fy, self.ty