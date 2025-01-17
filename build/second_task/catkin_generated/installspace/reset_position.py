#!/usr/bin/env python3

import rospy
from std_srvs.srv import Empty

def reset_position():
    rospy.init_node('reset_position')

    rospy.wait_for_service('/reset_positions')
    try:
        reset_srv = rospy.ServiceProxy('/reset_positions', Empty)
        reset_srv()
        rospy.loginfo("Robot position reset successful")
    except rospy.ServiceException as e:
        rospy.logerr(f"Reset service call failed: {e}")

if __name__ == '__main__':
    try:
        reset_position()
    except rospy.ROSInterruptException:
        pass