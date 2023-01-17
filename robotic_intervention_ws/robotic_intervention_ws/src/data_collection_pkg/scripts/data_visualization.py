#!/usr/bin/env python3

import rospy
import cv2
import numpy as np
from cv_bridge import CvBridge, CvBridgeError
from sensor_msgs.msg import Image
from std_msgs.msg import String


class Visualize_Data:
    def __init__(self):
        rospy.init_node("visualize_data", anonymous=True)
        self.bridge = CvBridge()
        self.cam1_img = np.zeros((600, 800, 3), np.uint8)
        self.cam2_img = np.zeros((600, 800, 3), np.uint8)
        cv2.startWindowThread()
        cv2.namedWindow("Camera_Feed_1")
        cv2.namedWindow("Camera_Feed_2")
        cv2.moveWindow('Camera_Feed_1', 100, 0)
        cv2.moveWindow('Camera_Feed_2', 1000, 0)
        cv2.imshow('Camera_Feed_1', self.cam1_img)
        cv2.imshow('Camera_Feed_2', self.cam2_img)

        self.count1, self.count2 = 1, 1
        self.t1, self.t2  = 1, 1

        rospy.Subscriber('/camera_1/camera_frames', Image, callback=self.camera1_image_callback)
        rospy.Subscriber('/camera_2/camera_frames', Image, callback=self.camera2_image_callback)

        rospy.spin()

    def camera1_image_callback(self, msg):
        self.cam1_img = self.bridge.imgmsg_to_cv2(msg)
        self.t1 = msg.header.stamp.to_nsec()
        rospy.loginfo("Camera 1 Frame: %i", self.t1)
        cv2.putText(img=self.cam1_img, text=f'{self.t1}', org=(100, 100), fontFace=cv2.FONT_HERSHEY_TRIPLEX,
                    fontScale=0.5, color=(0, 255, 0), thickness=1)
        cv2.imshow('Camera_Feed_1', self.cam1_img)
        self.count1 = self.count1+1

    def camera2_image_callback(self, msg):
        self.cam2_img = self.bridge.imgmsg_to_cv2(msg)
        self.t2 = msg.header.stamp.to_nsec()
        rospy.loginfo("Camera 2 Frame: %i", self.t2)
        cv2.putText(img=self.cam2_img, text=f'{self.t2}', org=(100, 100), fontFace=cv2.FONT_HERSHEY_TRIPLEX,
                    fontScale=0.5, color=(0, 255, 0), thickness=1)
        cv2.imshow('Camera_Feed_2', self.cam2_img)
        self.count2 = self.count2+1

    @staticmethod
    def end_process():
        cv2.destroyAllWindows()


if __name__ == '__main__':
    visuals = object
    try:
        visuals = Visualize_Data()
        print("Object Exiting")
    except BaseException as e:
        print(f"Issue Detected as {e}")
        rospy.loginfo("Issues")
    finally:
        if isinstance(visuals, Visualize_Data):
            print("Exiting Successfully")
            rospy.loginfo("Exiting Safely")
            visuals.end_process()


