#!/usr/bin/env python3

import rospy
from geometry_msgs.msg import Twist
from sensor_msgs.msg import LaserScan

class RobotController:
    def __init__(self):
        rospy.init_node('robot_controller', anonymous=True)
        self.velocity_publisher = rospy.Publisher('/cmd_vel', Twist, queue_size=10)
        self.laser_subscriber = rospy.Subscriber('/base_scan', LaserScan, self.laser_callback)
        self.rate = rospy.Rate(10)
        self.stop_robot = False

    def laser_callback(self, data):
        front_readings = data.ranges[80:100]
        min_distance = min(front_readings)

        if min_distance < 0.5:
            self.stop_robot = True
            rospy.loginfo("Engel tespit edildi! Robot durduruluyor...")

    def move_robot(self):
        vel_msg = Twist()

        while not rospy.is_shutdown():
            if self.stop_robot:
                vel_msg.linear.x = 0
                vel_msg.linear.y = 0
                vel_msg.linear.z = 0
                vel_msg.angular.x = 0
                vel_msg.angular.y = 0
                vel_msg.angular.z = 0
            else:
             
                vel_msg.linear.x = 0.5
                vel_msg.linear.y = 0.5
                vel_msg.linear.z = 0
                vel_msg.angular.x = 0
                vel_msg.angular.y = 0
                vel_msg.angular.z = 0

            self.velocity_publisher.publish(vel_msg)
            rospy.loginfo("Hız mesajı yayınlandı: x=%f y=%f", vel_msg.linear.x, vel_msg.linear_y)
            self.rate.sleep()

if __name__ == '__main__':
    try:
        controller = RobotController()
        controller.move_robot()
    except rospy.ROSInterruptException:
        pass