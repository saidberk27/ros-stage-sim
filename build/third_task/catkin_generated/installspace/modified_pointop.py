#!/usr/bin/env python3

import rospy
from geometry_msgs.msg import Twist, Point
from nav_msgs.msg import Odometry
from third_task.msg import Coordinates
from third_task.srv import Distance
import math

class TurtlebotController:
    def __init__(self):
        rospy.init_node('turtlebot3_pointop_key')

        self.pub = rospy.Publisher('/tb3_1/cmd_vel', Twist, queue_size=10)
        rospy.Subscriber('/tb3_1/odom', Odometry, self.odom_callback)
        rospy.Subscriber('/tb3_2/position', Coordinates, self.target_callback)

        self.position = Point()
        self.target_position = Point()
        self.got_target = False

        rospy.wait_for_service('calculate_distance')
        self.distance_service = rospy.ServiceProxy('calculate_distance', Distance)

    def target_callback(self, msg):
        self.target_position.x = msg.x
        self.target_position.y = msg.y
        self.got_target = True

    def odom_callback(self, msg):
        self.position = msg.pose.pose.position

    def get_distance(self):
        try:
            resp = self.distance_service(
                self.position.x,
                self.position.y,
                self.target_position.x,
                self.target_position.y
            )
            return resp.distance
        except rospy.ServiceException as e:
            rospy.logerr(f"Service call failed: {e}")
            return 0

    def move_to_target(self):
        rate = rospy.Rate(10)
        while not rospy.is_shutdown():
            if not self.got_target:
                continue

            distance = self.get_distance()

            if distance < 0.1:
                self.pub.publish(Twist())
                break

            # Hareket kontrolü buraya eklenecek
            # (Orijinal turtlebot3_pointop_key'den alınabilir)

            rate.sleep()

if __name__ == "__main__":
    try:
        controller = TurtlebotController()
        controller.move_to_target()
    except rospy.ROSInterruptException:
        pass