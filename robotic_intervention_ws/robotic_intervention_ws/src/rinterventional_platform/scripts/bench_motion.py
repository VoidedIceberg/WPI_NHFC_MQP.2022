#! /usr/bin/env python3

import rospy
import numpy as np

from rinterventional_platform import emt_pose_processor, custom_error_exceptions

BASE_FRAME = "polhemus_base_0"
EMT_SENSOR = "polhemus_station_0"
START_FRAME = "frame_0"
ROBOT_BENCH = "robot_bench"


def main():
    rospy.init_node('tf2_pubsub_node')
    tf_data = emt_pose_processor.EmtDataProcessor()
    bench_command = emt_pose_processor.BenchCommandGenerator()

    rospy.sleep(1)
    rate = rospy.Rate(10)

    initial_frame_published = False

    while not initial_frame_published:
        try:
            trans_base2first_frame = tf_data.get_tf_between(BASE_FRAME, EMT_SENSOR)
            tf_data.broadcast_tf(trans_base2first_frame, frame_name=START_FRAME,
                                 base_frame=BASE_FRAME, br_type='dynamic')

            initial_frame_published = True
        except custom_error_exceptions.TFDataRetrieveError as err:
            rospy.logwarn(f"Error caught- {err}")

    while not rospy.is_shutdown():
        trans_base2emt   = tf_data.get_tf_between(BASE_FRAME, EMT_SENSOR)
        trans_base2first = tf_data.get_tf_between(BASE_FRAME, START_FRAME)

        trans_base2start = tf_data.calculate_tf_between(trans_base2first, trans_base2emt)
        trans_base2start = tf_data.adjust_tf_data(trans_base2start, y=0,z=0)

        linear_steps, angular_steps, _, _ = bench_command.convert_tf_to_steps(trans_base2start)
        bench_command.publish_step_commands(linear_steps, angular_steps)
        rate.sleep()

        tf_data.broadcast_tf(trans_base2start, frame_name=ROBOT_BENCH,
                             base_frame=START_FRAME, br_type='dynamic')






if __name__ == '__main__':
    main()