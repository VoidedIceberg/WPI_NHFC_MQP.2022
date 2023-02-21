#!/usr/bin/env python3

import rospy
import numpy as np
import re
import serial, serial.tools.list_ports
from geometry_msgs.msg import Vector3
from geometry_msgs.msg import WrenchStamped


class SerialHandler:
    def __init__(self, send_port=None, receive_port=None, baudrate=None, timeout=0.1):
        self.all_ports = serial.tools.list_ports.comports()
        self.port_list = []
        self.send_port, self.receive_port = send_port, receive_port
        self.serialSender, self.serialReceiver = None, None

        self.baud = baudrate
        self.timeout = timeout

        self.linear_steps = 0
        self.angular_steps = 0

        self.display_all_ports()
        self.select_ports()

    def display_all_ports(self):
        for port in self.all_ports:
            self.port_list.append(str(port))
            rospy.loginfo("\t\t" + str(self.all_ports.index(port) + 1) + " " + str(port))

    def select_ports(self):
        send_port_index = input(f"Select port for sending position:")
        self.send_port = self.port_list[int(send_port_index) - 1].split(" ")[0]

        receive_port_index = input(f"Select port for receiving force data:")
        self.receive_port = self.port_list[int(receive_port_index) - 1].split(" ")[0]

    def establish_connection(self):

        self.serialSender = serial.Serial(port=self.send_port, baudrate=self.baud, timeout=self.timeout)
        self.serialReceiver = serial.Serial(port=self.receive_port, baudrate=self.baud, timeout=self.timeout)

        self.serialSender.close()
        self.serialReceiver.close()

        self.serialSender.open()
        self.serialReceiver.open()

    def check_connection(self):
        if self.serialSender.isOpen():
            rospy.loginfo("\t\t" + "Connection with sender port is open")
        else:
            rospy.loginfo("\t\t" + "Connection failed with sender port")

        if self.serialReceiver.isOpen():
            rospy.loginfo("\t\t" + "Connection with receiving port is open")
        else:
            rospy.loginfo("\t\t" + "Connection failed with receiving port")

        if self.serialSender.isOpen() and self.serialReceiver.isOpen():
            return True
        else:
            return False

    def close_all_ports(self):
        if self.check_connection():
            self.serialSender.close()
            self.serialReceiver.close()
            rospy.loginfo("\t\t" + "Closing ports safely")
        else:
            rospy.loginfo("\t\t" + "Error occurred or ports are already closed")

    def send_data(self, volt_L, volt_R):
        data2send = f"V R{volt_L} L{volt_R}\n"
        rospy.loginfo("\t\t" + data2send)
        self.serialSender.write(data2send.encode())

    def receive_data(self):

        if self.serialReceiver.in_waiting:
            serial_stream = self.serialReceiver.readline()
            data = serial_stream.decode("ascii").split(' ')

            if self.is_output_legal(data):

                r_part = data[1]
                r_part = re.sub("R", " ", r_part)

                l_part = data[2]
                l_part = re.sub("L", " ", l_part)

                self.linear_steps = float(r_part)
                self.angular_steps = float(l_part)
                rospy.loginfo("\t\tReceived data : L: %f ,  A: %f ", self.linear_steps, self.angular_steps)
            else:
                rospy.loginfo("\t\t" + "Received corrupted data")
        else:
            pass
            # rospy.loginfo("\t\t" + "Waiting for Data")

    def is_output_legal(self, data):  # check if the output is legal
        if len(data) < 2:  # check if the output is completed
            return 0
        return 1
