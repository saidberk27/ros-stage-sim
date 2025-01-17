#!/usr/bin/env python3

import rospy
from geometry_msgs.msg import Twist, Point
from nav_msgs.msg import Odometry
from third_task.msg import Coordinates
from third_task.srv import Distance
import math
import tf
from math import atan2

class TurtlebotController:
    def __init__(self):
        rospy.init_node('turtlebot3_pointop_key')

        self.pub = rospy.Publisher('tb3_1/cmd_vel', Twist, queue_size=10)
        rospy.Subscriber('tb3_1/odom', Odometry, self.odom_callback)
        rospy.Subscriber('tb3_2/initial_position', Coordinates, self.target_callback)  # Topic ismini düzelttik

        self.position = Point()
        self.target_position = Point()
        self.got_target = False
        self.yaw = 0
        self.rate = rospy.Rate(10)

        rospy.wait_for_service('calculate_distance')
        self.distance_service = rospy.ServiceProxy('calculate_distance', Distance)
        rospy.loginfo("Controller node started and waiting for target position...")

    def target_callback(self, msg):
        self.target_position.x = msg.x
        self.target_position.y = msg.y
        self.got_target = True
        rospy.loginfo(f"Target position received: x={msg.x}, y={msg.y}")

    def odom_callback(self, msg):
        self.position = msg.pose.pose.position

        # Yaw açısını quaternion'dan hesaplama
        orientation_q = msg.pose.pose.orientation
        orientation_list = [orientation_q.x, orientation_q.y, orientation_q.z, orientation_q.w]
        (roll, pitch, self.yaw) = tf.transformations.euler_from_quaternion(orientation_list)

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
        while not rospy.is_shutdown():
            if not self.got_target:
                rospy.loginfo("Hedef bekleniyor...")
                self.rate.sleep()
                continue

            distance = self.get_distance()

            if distance < 0.1:
                rospy.loginfo("Hedefe ulaşıldı!")
                self.pub.publish(Twist())
                break

            # Hedefe doğru açıyı hesapla
            target_angle = atan2(self.target_position.y - self.position.y,
                               self.target_position.x - self.position.x)

            # Açı farkını hesapla
            angle_diff = target_angle - self.yaw

            # Açı farkını -pi ile pi arasına normalize et
            while angle_diff > math.pi:
                angle_diff -= 2 * math.pi
            while angle_diff < -math.pi:
                angle_diff += 2 * math.pi

            # Hareket komutunu oluştur
            twist = Twist()

            # Açısal hız kontrolü
            if abs(angle_diff) > 0.1:
                twist.angular.z = 0.5 if angle_diff > 0 else -0.5
                twist.linear.x = 0.0
            else:
                # Doğrusal hız kontrolü
                twist.angular.z = 0.0
                twist.linear.x = min(0.2, distance)

            self.pub.publish(twist)
            rospy.loginfo(f"Mesafe: {distance:.2f}, Açı farkı: {math.degrees(angle_diff):.2f} derece")
            self.rate.sleep()

if __name__ == "__main__":
    try:
        controller = TurtlebotController()
        controller.move_to_target()
    except rospy.ROSInterruptException:
        pass