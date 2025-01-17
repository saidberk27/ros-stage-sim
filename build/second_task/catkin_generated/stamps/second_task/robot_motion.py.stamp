#!/usr/bin/env python

import rospy
from geometry_msgs.msg import Twist
from sensor_msgs.msg import LaserScan
from nav_msgs.msg import Odometry
import math
import tf

class RobotController:
    def __init__(self):
        rospy.init_node('robot_controller', anonymous=True)
        self.velocity_publisher = rospy.Publisher('/cmd_vel', Twist, queue_size=10)
        self.laser_subscriber = rospy.Subscriber('/base_scan', LaserScan, self.laser_callback)
        self.odom_subscriber = rospy.Subscriber('/odom', Odometry, self.odom_callback)

        self.rate = rospy.Rate(10)
        self.stop_robot = False
        self.direction = "UP"
        self.state = "MOVE_FORWARD"

        # Odometry ve yönelim değişkenleri
        self.current_yaw = 0.0

        # Laser scan data
        self.right_side_clear = True
        self.front_clear = True

        # Dönüş parametreleri
        self.Kp = 0.8
        self.angle_tolerance = math.radians(1.0)

        self.R = rospy.get_param('/robot_parameters/R', 3.0)  # Varsayılan değer 3.0

    def odom_callback(self, msg):
        orientation_q = msg.pose.pose.orientation
        (roll, pitch, yaw) = tf.transformations.euler_from_quaternion([
            orientation_q.x, orientation_q.y, orientation_q.z, orientation_q.w
        ])
        self.current_yaw = yaw

    def laser_callback(self, data):
        front_readings = data.ranges[80:100]
        self.front_clear = min(front_readings) >= 0.5

        right_readings = data.ranges[0:10]
        self.right_side_clear = min(right_readings) >= 1.0

        if not self.front_clear and self.state == "MOVE_FORWARD":
            self.stop_robot = True
            rospy.loginfo("Engel tespit edildi! Yön değiştirilecek...")
            self.state = "ROTATE"

    def normalize_angle(self, angle):
        while angle > math.pi:
            angle -= 2.0 * math.pi
        while angle < -math.pi:
            angle += 2.0 * math.pi
        return angle

    def rotate_precise(self, target_angle_deg):
        """
        Closed-loop kontrol ile hassas dönüş
        """
        target_angle = math.radians(target_angle_deg)
        target_yaw = self.normalize_angle(self.current_yaw + target_angle)

        vel_msg = Twist()

        while not rospy.is_shutdown():
            current_yaw = self.normalize_angle(self.current_yaw)
            remaining = self.normalize_angle(target_yaw - current_yaw)

            if abs(remaining) < self.angle_tolerance:
                vel_msg.angular.z = 0
                self.velocity_publisher.publish(vel_msg)
                rospy.sleep(0.5)
                break

            angular_speed = self.Kp * remaining

            if angular_speed > 1.5:
                angular_speed = 1.5
            elif angular_speed < -1.5:
                angular_speed = -1.5

            vel_msg.angular.z = angular_speed
            self.velocity_publisher.publish(vel_msg)
            self.rate.sleep()

    def move_forward_precise(self, distance, speed=1.0):
        vel_msg = Twist()
        vel_msg.linear.x = speed

        duration = distance / speed
        start_time = rospy.Time.now()

        while (rospy.Time.now() - start_time).to_sec() < duration:
            if rospy.is_shutdown():
                break
            self.velocity_publisher.publish(vel_msg)
            self.rate.sleep()

        vel_msg.linear.x = 0
        self.velocity_publisher.publish(vel_msg)
        rospy.sleep(0.5)

    def move_robot(self):
        vel_msg = Twist()

        while not rospy.is_shutdown():
            if self.state == "MOVE_FORWARD":
                if not self.stop_robot:
                    vel_msg.linear.x = 1.0
                    vel_msg.angular.z = 0
                else:
                    vel_msg.linear.x = 0
                    vel_msg.angular.z = 0
                    self.state = "ROTATE"
                    rospy.sleep(0.5)

            elif self.state == "ROTATE":
                rospy.loginfo(f"Dönüş yapılıyor... Yön: {self.direction}")

                if self.direction == "UP":
                    if self.right_side_clear:
                        # Sağa dön
                        self.rotate_precise(-90)
                        # İleri git
                        self.move_forward_precise(self.R)
                        # Aşağı yöne dön
                        self.rotate_precise(-90)
                        self.direction = "DOWN"
                    else:
                        rospy.loginfo("Sağ tarafta yer kalmadı, parkur tamamlandı!")
                        return

                elif self.direction == "DOWN":
                    if self.right_side_clear:
                        # Sola dön
                        self.rotate_precise(90)
                        # İleri git
                        self.move_forward_precise(self.R)
                        # Yukarı yöne dön
                        self.rotate_precise(90)
                        self.direction = "UP"
                    else:
                        rospy.loginfo("Sağ tarafta yer kalmadı, parkur tamamlandı!")
                        return

                self.state = "MOVE_FORWARD"
                self.stop_robot = False

            self.velocity_publisher.publish(vel_msg)
            self.rate.sleep()

if __name__ == '__main__':
    try:
        controller = RobotController()
        rospy.sleep(1)  # Odometry verilerinin gelmesi için bekle
        controller.move_robot()
    except rospy.ROSInterruptException:
        pass