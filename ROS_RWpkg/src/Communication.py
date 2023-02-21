#!/usr/bin/env python3

import rospy
import numpy as np
import re

import serial
import serial.rs485
import serial, serial.tools.list_ports

from geometry_msgs.msg import Vector3
from geometry_msgs.msg import WrenchStamped
from std_msgs.msg import String

from FT_DataReader import *
from SerialHandler import *
from RosDataHandler import *

if __name__ == '__main__':
    try:
        FT_Handler = FT_DataReader()
        rosHandler = RosDataHandler(1, 1)
        serial_handler = SerialHandler(baudrate=57600, timeout=0.001)
        serial_handler.establish_connection()
        if serial_handler.check_connection():
            count = 0.0
            while not rospy.is_shutdown():
                serial_handler.receive_data()
                serial_handler.send_data(count, count)
                # serial_handler.serialSender.flush()
                rospy.sleep(0.5)

    except Exception as e:
        err = "Exception occurred : " + str(e)
        rospy.loginfo(err)

    finally:
        serial_handler.close_all_ports()
