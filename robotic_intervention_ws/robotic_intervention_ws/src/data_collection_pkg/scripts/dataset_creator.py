#! /usr/bin/env python3

import rospy
import message_filters
import numpy as np

import cv2
import tf2_ros
from cv_bridge import CvBridge, CvBridgeError
from sensor_msgs.msg import Image

from data_collection_pkg.emt_pose_processor import EmtDataProcessor, EmtDataFormatter

START_FRAME = "frame_0"
ROBOT_BENCH = "robot_bench"

## TASKs LIST:
#1 Have to subscribe to the published tf topic and get the taransform between specific frames.
#2 Then convert the relative tf to linear and continuous angular data.


class DataSet_Handler:

    def __init__(self):
        self.tf_data = EmtDataProcessor()
        self.data_fromatter = EmtDataFormatter()
        self.bridge = CvBridge()

        self.cam1 = message_filters.Subscriber("/camera_1/camera_frames", Image)
        self.cam2 = message_filters.Subscriber("/camera_2/camera_frames", Image)
        self.cam1_stack = np.zeros((600, 800, 3))
        self.cam2_stack = np.zeros((600, 800, 3))
        self.pose_stack = np.zeros((1, 2))
        self.time_stack = np.zeros((1, 3))
        self.count = 0

        # self.pose = tf_data.init_tf_data(START_FRAME, ROBOT_BENCH)
        # self.pose = tf_data.get_tf_between(START_FRAME, ROBOT_BENCH)

        self.sync_message = message_filters.ApproximateTimeSynchronizer([self.cam1, self.cam2],
                                                                   queue_size=100, slop=0.1)

        self.sync_message.registerCallback(self.approx_sync_callback)

        print("GETTING ALL THE SYNCED")

    def approx_sync_callback(self, cam1, cam2):
        try:
            cam1_img = self.bridge.imgmsg_to_cv2(cam1)
            cam2_img = self.bridge.imgmsg_to_cv2(cam2)
            pose = self.tf_data.get_tf_between(START_FRAME, ROBOT_BENCH)
            translation, rotation = self.data_fromatter.convert_tf_to_2D(pose)
            pose_trim = np.array([translation, rotation])


            time_array = np.array([cam1.header.stamp.to_sec(), cam2.header.stamp.to_sec(), pose.header.stamp.to_sec()])
            self.time_stack = np.vstack((self.time_stack, time_array))
            self.pose_stack = np.vstack((self.pose_stack, pose_trim))

            self.count += 1
            info = f"Data Count: {self.count}"

            side_image_filename = f'Side_Image/S_{self.count}.jpg'
            top_image_filename  = f'Top_Image/T_{self.count}.jpg'

            cv2.imwrite(side_image_filename, cam1_img)
            cv2.imwrite(top_image_filename, cam2_img)

            rospy.loginfo(info)

        except (CvBridgeError,
                tf2_ros.LookupException,
                tf2_ros.ConnectivityException,
                tf2_ros.ExtrapolationException) as e:
            print(e)


if __name__ == '__main__':
    try:
        rospy.init_node('save_synced_all', anonymous=True)
        ip = DataSet_Handler()
        rospy.spin()
    finally:
        np.save('Pose_Array', ip.pose_stack)
        np.save('Time_Array', ip.time_stack)
        np.savetxt("Pose_Array.csv", ip.pose_stack, delimiter=",", fmt='%f')
        np.savetxt("Time_Array.csv", ip.time_stack, delimiter=",", fmt='%f')
