#!/usr/bin/env python3

import rospy
from nav_msgs.msg import Odometry
from third_task.msg import Coordinates

class PositionPublisher:
    def __init__(self):
        rospy.init_node('tb3_2_position_publisher')
        self.pub = rospy.Publisher('tb3_2/initial_position', Coordinates, queue_size=10)
        self.initial_position_sent = False
        rospy.Subscriber('tb3_2/odom', Odometry, self.odom_callback)
        rospy.loginfo("Position publisher started")

    def odom_callback(self, msg):
        # Sadece başlangıç konumunu bir kez yayınla
        if not self.initial_position_sent:
            coord = Coordinates()
            coord.x = msg.pose.pose.position.x
            coord.y = msg.pose.pose.position.y
            self.pub.publish(coord)
            self.initial_position_sent = True
            rospy.loginfo(f"tb3_2 initial position published: x={coord.x}, y={coord.y}")

if __name__ == '__main__':
    try:
        PositionPublisher()
        rospy.spin()
    except rospy.ROSInterruptException:
        pass