#! /usr/bin/env python3

import rospy


class InitializationError(Exception):
    pass


class TFDataRetrieveError(Exception):
    pass