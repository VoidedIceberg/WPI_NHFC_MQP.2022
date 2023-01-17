#! /usr/bin/env python3

import rospy
from sensor_msgs.msg import Image
from cv_bridge import CvBridge, CvBridgeError
import cv2
# import gi
# gi.require_version('Gtk', '2.0')


class Camera_Handler:

    def __init__(self):
        # Initialize Node:Will be overwritten by launch files)
        rospy.init_node('data_recoder_node', anonymous=False, log_level=rospy.INFO)
        self.node_name = rospy.get_caller_id()  # Get the final node name(maybe overwritten)

        # Create CV-Bridge to convert and read Image as ros msg
        self.bridge = CvBridge()

        # Create a publisher object
        self.pub  = rospy.Publisher(self.node_name + '/camera_frames', Image, queue_size=1)
        self.rate = rospy.Rate(20)
        rospy.loginfo("Running from: %s node and publishing topic: %s", self.node_name,
                      self.node_name + "/camera_frames")

        # Set camera Parameters
        self.local_cam_id = self.node_name + '/cam_id'
        self.cap = cv2.VideoCapture(rospy.get_param(self.local_cam_id))
        self.set_camera_parameters()

    def set_camera_parameters(self):
        # Notify if the camera port is accessible
        rospy.loginfo("%s is open: %s", self.node_name, self.cap.isOpened())

        # Working Frame Configuration:  800x600 with 20 fps by default:
        width  = rospy.get_param(self.node_name  + "/width")
        height = rospy.get_param(self.node_name  + "/height")
        fps    = 20

        self.cap.set(cv2.CAP_PROP_FRAME_WIDTH, width)
        self.cap.set(cv2.CAP_PROP_FRAME_HEIGHT, height)
        self.cap.set(cv2.CAP_PROP_FPS, fps)

    def publish_frames(self):

        while not rospy.is_shutdown():
            ret, frame = self.cap.read()
            if not ret:
                break
            msg = self.bridge.cv2_to_imgmsg(frame, 'bgr8')
            msg.header.stamp = rospy.get_rostime()
            self.pub.publish(msg)

            if rospy.is_shutdown():
                self.cap.release()


if __name__ == '__main__':
    cam_obj = object
    try:
        cam_obj = Camera_Handler()
        cam_obj.publish_frames()

    except rospy.ROSInterruptException:
        pass

