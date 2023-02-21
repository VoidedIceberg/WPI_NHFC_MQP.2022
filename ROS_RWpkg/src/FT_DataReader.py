import rospy
import numpy as np
import serial
import serial.rs485

from geometry_msgs.msg import WrenchStamped
from std_msgs.msg import String

class FT_DataReader:
    def __init__(self, baudrate=115200, bit_size=32, rdt_rate=1953, adc_rate=1953):
        # Sensor Parameters
        self.baud = baudrate
        self.bit = bit_size
        self.rdt = rdt_rate
        self.adc = adc_rate
        self.ft_data = WrenchStamped()
        self.Fx, self.Fy, self.Fz, self.Tx, self.Ty, self.Tz = 0, 0, 0, 0, 0, 0

        # ROS Pub Parameters
        rospy.init_node("ft_data_streamer", anonymous=False)
        self.node_name = rospy.get_caller_id()
        self.topic_name = '/ft_data'
        self.pub = rospy.Publisher(self.topic_name, WrenchStamped, queue_size=10)
        self.rate = rospy.Rate(500)
        rospy.loginfo("\tRunning from %s node", self.node_name)
        rospy.loginfo("\tPublishing topic: %s", self.topic_name)

        try:
            self.ser = None
            self.ser = serial.rs485.RS485(port='/dev/ttyUSB0', baudrate=self.baud, timeout=1)
            self.ser.rs485_mode = serial.rs485.RS485Settings(rts_level_for_rx=True, rts_level_for_tx=False)
            self.set_connection_parameters()
            self.read_ft()

        except Exception as e:
            print(f"High Level Error: {e}")
        finally:
            if self.ser != None and self.ser.isOpen():
                self.ser.close()

    def hex_dec(self, hex_num):
        if self.bit == 16:
            num_bit = 4
        else:
            num_bit = 8

        sln = hex_num[0]
        Fx = self.toDec(hex_num[1:(1 + num_bit)])
        Fy = self.toDec(hex_num[(1 + num_bit):(1 + (2 * num_bit))])
        Fz = self.toDec(hex_num[(1 + (2 * num_bit)):(1 + (3 * num_bit))])
        Tx = self.toDec(hex_num[(1 + (3 * num_bit)):(1 + (4 * num_bit))])
        Ty = self.toDec(hex_num[(1 + (4 * num_bit)):(1 + (5 * num_bit))])
        Tz = self.toDec(hex_num[(1 + (5 * num_bit)):(1 + (6 * num_bit))])

        return sln, Fx, Fy, Fz, Tx, Ty, Tz

    def toDec(self, hexstr):
        BIT = self.bit
        msb4bits = hexstr[0]
        n = int(msb4bits, 16)
        if n >= 8:
            p = -1 * pow(2, BIT - 1)
            addend = int(str(n - 8) + hexstr[1:], 16)

            return int(str(p + addend))

        else:
            return int(hexstr, 16)

    def read_ft(self):
        while not rospy.is_shutdown():
            try:
                data_r = self.ser.readline()
                data1 = data_r.decode('utf-8')
                sln, Fx, Fy, Fz, Tx, Ty, Tz = self.hex_dec(data1)
            except:
                sln, Fx, Fy, Fz, Tx, Ty, Tz = None, None, None, None, None, None, None
                rospy.loginfo("Invalid Data")

            if sln:
                if self.bit == 16:
                    scale = 15.258789
                else:
                    scale = 1000000

                Fx, Fy, Fz, Tx, Ty, Tz = [item * (1 / scale) for item in [Fx, Fy, Fz, Tx, Ty, Tz]]
                self.Fx, self.Fy, self.Fz, self.Tx, self.Ty, self.Tz = Fx, Fy, Fz, Tx, Ty, Tz
            else:
                pass

            self.ft_data.wrench.force.x = self.Fx
            self.ft_data.wrench.force.y = self.Fy
            self.ft_data.wrench.force.z = self.Fz

            self.ft_data.wrench.torque.x = self.Tx
            self.ft_data.wrench.torque.y = self.Ty
            self.ft_data.wrench.torque.z = self.Tz

            self.ft_data.header.stamp = rospy.get_rostime()
            self.pub.publish(self.ft_data)

    def set_ft_adc(self):
        if self.adc <= 488:
            self.ser.write(b'a0')
        elif self.adc <= 976:
            self.ser.write(b'a1')
        elif self.adc <= 1953:
            self.ser.write(b'a2')
        elif self.adc <= 3906:
            self.ser.write(b'a3')
        else:
            self.ser.write(b'a4')

    def adjust_bias(self):
        self.ser.write(b'o')

    def set_size_of_data(self):
        if self.bit == 16:
            self.ser.write(b'w2')
        elif self.bit == 32:
            self.ser.write(b'w4')

    def set_connection_parameters(self):
        self.ser.write(b'e')
        rospy.sleep(1)
        self.set_size_of_data()
        rospy.sleep(1)
        self.set_ft_adc()
        rospy.sleep(1)
        self.adjust_bias()
        rospy.sleep(1)

        self.ser.write(b's')
        rospy.sleep(2)
