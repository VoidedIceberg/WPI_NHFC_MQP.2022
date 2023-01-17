#! /usr/bin/env python3
import numpy as np

import rospy
import tf2_ros
import tf_conversions
import geometry_msgs.msg
from rinterventional_platform import custom_error_exceptions
from custom_msg_srv_package.msg import control_steps


class EmtDataProcessor:

    def __init__(self, ref_frame="Dummy_ref", tar_frame="Dummy_tar"):
        self.tfBuffer = tf2_ros.Buffer()
        self.listener = tf2_ros.TransformListener(self.tfBuffer)
        self.br = tf2_ros.TransformBroadcaster()
        self.br_static = tf2_ros.StaticTransformBroadcaster()
        self.last_pose = self.init_tf_data(ref_frame, tar_frame)

    def get_tf_between(self, reference_frame, target_frame):
        try:
            transformation = self.tfBuffer.lookup_transform(reference_frame, target_frame, rospy.Time())
            info = f"Got {reference_frame}->{target_frame} transform"
            rospy.loginfo(info)
            self.last_pose = transformation
        except (tf2_ros.LookupException, tf2_ros.ConnectivityException, tf2_ros.ExtrapolationException) as err:
            rospy.logwarn(f"Looking for transform - {err}")
            raise custom_error_exceptions.TFDataRetrieveError("Error while retrieving TF Data")

        return self.last_pose

    def calculate_tf_between(self, frame1, frame2):

        if frame1.header.frame_id == frame1.header.frame_id:

            t2 = self.init_tf_data(frame1.header.frame_id, "Still_Unnamed")

            x0 = frame1.transform.translation.x
            x1 = frame2.transform.translation.x

            qx0 = frame1.transform.rotation.x
            qy0 = frame1.transform.rotation.y
            qz0 = frame1.transform.rotation.z
            qw0 = frame1.transform.rotation.w

            qx1 = frame2.transform.rotation.x
            qy1 = frame2.transform.rotation.y
            qz1 = frame2.transform.rotation.z
            qw1 = frame2.transform.rotation.w

            q0 = [qx0, qy0, qz0, qw0]
            q1 = [qx1, qy1, qz1, qw1]

            q0_inv = tf_conversions.transformations.quaternion_inverse(q0)
            q2 = tf_conversions.transformations.quaternion_multiply(q0_inv, q1)
            roll, pitch, yaw = tf_conversions.transformations.euler_from_quaternion(q2)
            q2_mod = tf_conversions.transformations.quaternion_from_euler(roll, 0, 0)

            t2.transform.translation.x = x1 - x0
            t2.transform.translation.y = 0.0
            t2.transform.translation.z = 0.0

            t2.transform.rotation.x = q2_mod[0]
            t2.transform.rotation.y = q2_mod[1]
            t2.transform.rotation.z = q2_mod[2]
            t2.transform.rotation.w = q2_mod[3]

            return t2
        else:
            rospy.logerr("THE BASE REFERENCE FRAME DOES NOT MATCH")

    def broadcast_tf(self, msg, frame_name, base_frame="polhemus_base_0", br_type='dynamic'):
        if br_type == 'dynamic':
            br = tf2_ros.TransformBroadcaster()
        else:
            br = tf2_ros.StaticTransformBroadcaster()

        t = geometry_msgs.msg.TransformStamped()

        t.header.stamp = rospy.Time.now()
        t.header.frame_id = base_frame
        t.child_frame_id  = frame_name
        t.transform.translation.x = msg.transform.translation.x
        t.transform.translation.y = msg.transform.translation.y
        t.transform.translation.z = msg.transform.translation.z

        t.transform.rotation.x = msg.transform.rotation.x
        t.transform.rotation.y = msg.transform.rotation.y
        t.transform.rotation.z = msg.transform.rotation.z
        t.transform.rotation.w = msg.transform.rotation.w

        br.sendTransform(t)

    @staticmethod
    def init_tf_data(ref_frame, child_frame):
        t = geometry_msgs.msg.TransformStamped()
        t.header.stamp = rospy.Time.now()
        t.header.frame_id = ref_frame
        t.child_frame_id  = child_frame
        t.transform.translation.x = 0.0
        t.transform.translation.y = 0.0
        t.transform.translation.z = 0.0

        t.transform.rotation.x = 0.0
        t.transform.rotation.y = 0.0
        t.transform.rotation.z = 0.0
        t.transform.rotation.w = 1

        return t

    @staticmethod
    def adjust_tf_data(original_tf, x=None, y=None, z=None, qx=None, qy=None, qz=None, qw=None):
        if x:
            original_tf.transform.translation.x = x
        if y:
            original_tf.transform.translation.y = y
        if z:
            original_tf.transform.translation.x = z

        if qx:
            original_tf.transform.rotation.x = qx
        if qy:
            original_tf.transform.rotation.y = qy
        if qz:
            original_tf.transform.rotation.z = qz
        if qw:
            original_tf.transform.rotation.w = qw

        return original_tf


class BenchCommandGenerator:
    def __init__(self):
        self.linear_resolution  = 0.18
        self.angular_resolution = 1.8/8

        self.previous_roll_angle = 0.0
        self.absolute_roll = 0.0

        self.pub_steps = rospy.Publisher('Step_Generator', geometry_msgs.msg.Vector3, queue_size=10)

    def continuous_angle_generator(self, current_roll_angle):
        roll_increment = current_roll_angle - self.previous_roll_angle

        if roll_increment >= 0:
            if roll_increment >= np.pi:
                absolute_roll = self.absolute_roll - abs((np.pi*2)-roll_increment)
            else:
                absolute_roll = self.absolute_roll + roll_increment
        else:
            if roll_increment <= -np.pi:
                absolute_roll = self.absolute_roll + abs((np.pi*2)+roll_increment)
            else:
                absolute_roll = self.absolute_roll + roll_increment

        self.absolute_roll = absolute_roll
        self.previous_roll_angle = current_roll_angle

        return absolute_roll

    def convert_tf_to_steps(self, relative_frame):
        x1 = relative_frame.transform.translation.x

        qx = relative_frame.transform.rotation.x
        qy = relative_frame.transform.rotation.y
        qz = relative_frame.transform.rotation.z
        qw = relative_frame.transform.rotation.w
        quat= [qx, qy, qz, qw]
        roll, pitch, yaw = tf_conversions.transformations.euler_from_quaternion(quat)
        absolute_roll = self.continuous_angle_generator(roll)

        linear_steps = (x1*1000)/self.linear_resolution
        angular_steps = (absolute_roll*180)/(np.pi*self.angular_resolution)

        return linear_steps, angular_steps, (x1*1000), ((absolute_roll*180)/(np.pi))

    def set_step_resolution(self, linear_resolution, angular_resolution):
        self.linear_resolution  = linear_resolution
        self.angular_resolution = angular_resolution

    def publish_step_commands(self, linear_steps, angular_steps):
        # step_data = control_steps()
        step_data = geometry_msgs.msg.Vector3()

        step_data.x = linear_steps
        step_data.y = angular_steps
        step_data.z = 0

        self.pub_steps.publish(step_data)

    @staticmethod
    def get_topic_name():
        return '/Step_Generator'
