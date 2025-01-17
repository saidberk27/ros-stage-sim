#!/usr/bin/env python3

import rospy
import numpy as np
from geometry_msgs.msg import Twist
from nav_msgs.msg import Odometry
from math import atan2, sqrt, pi
import random
import time

class DFSExplorer:
    def __init__(self):
        rospy.init_node('dfs_explorer')

        # Grid parametreleri
        self.grid_size = 4
        self.cell_size = 1.0  # Her hücrenin metre cinsinden boyutu
        self.adjacency_matrix = np.zeros((16, 16))
        self.visited = [False] * 16
        self.rewards = [0] * 16
        self.current_cell = 0

        # Robot pozisyonu
        self.robot_x = 0
        self.robot_y = 0
        self.robot_theta = 0

        # ROS iletişimi
        self.cmd_vel_pub = rospy.Publisher('/cmd_vel', Twist, queue_size=1)
        self.odom_sub = rospy.Subscriber('/odom', Odometry, self.odom_callback)

        # Harita ve ödülleri oluştur
        self.create_adjacency_matrix()
        self.place_rewards(3)

        # Hareket parametreleri
        self.move_speed = 2.4
        self.turn_speed = 2.4
        self.distance_threshold = 0.05
        self.angle_threshold = 0.05

    def create_adjacency_matrix(self):
        obstacles = [(0,3), (1,2), (2,1)]  # Siyah hücreler

        for i in range(self.grid_size):
            for j in range(self.grid_size):
                current = i * self.grid_size + j
                if (i,j) not in obstacles:
                    if i > 0 and (i-1,j) not in obstacles:
                        self.adjacency_matrix[current][current-self.grid_size] = 1
                    if j < self.grid_size-1 and (i,j+1) not in obstacles:
                        self.adjacency_matrix[current][current+1] = 1
                    if i < self.grid_size-1 and (i+1,j) not in obstacles:
                        self.adjacency_matrix[current][current+self.grid_size] = 1
                    if j > 0 and (i,j-1) not in obstacles:
                        self.adjacency_matrix[current][current-1] = 1

    def place_rewards(self, num_rewards):
        free_cells = [i for i in range(16) if sum(self.adjacency_matrix[i]) > 0]
        reward_cells = random.sample(free_cells, num_rewards)
        for cell in reward_cells:
            self.rewards[cell] = 1
            rospy.loginfo(f"Reward placed at cell {cell}")

    def cell_to_coordinate(self, cell):
        row = cell // self.grid_size
        col = cell % self.grid_size
        x = col * self.cell_size - (self.grid_size * self.cell_size) / 2 + self.cell_size/2
        y = -row * self.cell_size + (self.grid_size * self.cell_size) / 2 - self.cell_size/2
        return x, y

    def move_to_cell(self, target_cell):
        target_x, target_y = self.cell_to_coordinate(target_cell)

        # Önce x ekseni boyunca hareket et
        if abs(target_x - self.robot_x) > self.distance_threshold:
            # X ekseni için hedef açı
            target_angle = 0 if target_x > self.robot_x else pi
            self.rotate_to(target_angle)
            self.move_forward(abs(target_x - self.robot_x))
            self.adjust_position(target_x, self.robot_y)  # X pozisyonunu düzelt

        # Sonra y ekseni boyunca hareket et
        if abs(target_y - self.robot_y) > self.distance_threshold:
            # Y ekseni için hedef açı
            target_angle = pi/2 if target_y > self.robot_y else -pi/2
            self.rotate_to(target_angle)
            self.move_forward(abs(target_y - self.robot_y))
            self.adjust_position(target_x, target_y)  # Final pozisyonu düzelt

        rospy.loginfo(f"Moved to cell {target_cell}")
        rospy.sleep(0.5)  # Hareket arası bekleme

    def adjust_position(self, target_x, target_y, max_attempts=3):
        """Robotun pozisyonunu hedef koordinatlara hassas şekilde ayarlar"""
        attempt = 0
        while attempt < max_attempts and not rospy.is_shutdown():
            dx = target_x - self.robot_x
            dy = target_y - self.robot_y
            distance = sqrt(dx*dx + dy*dy)

            if distance < self.distance_threshold:
                break

            # Düzeltme açısını hesapla
            correction_angle = atan2(dy, dx)
            self.rotate_to(correction_angle)

            # Yavaş hızda düzeltme hareketi
            correction_speed = min(self.move_speed * 0.5, distance)
            twist = Twist()
            twist.linear.x = correction_speed

            # Küçük adımlarla hareket et
            start_time = rospy.Time.now()
            while (rospy.Time.now() - start_time).to_sec() < 0.5:
                self.cmd_vel_pub.publish(twist)
                rospy.sleep(0.05)

                # Hedefe ulaştıysak döngüyü kır
                if sqrt((target_x - self.robot_x)**2 + (target_y - self.robot_y)**2) < self.distance_threshold:
                    break

            self.stop_robot()
            attempt += 1

        # Son pozisyonu sabitle
        self.stop_robot()

    def rotate_to(self, target_angle):
        while not rospy.is_shutdown():
            angle_diff = target_angle - self.robot_theta

            # Açı farkını -pi ile pi arasına normalize et
            while angle_diff > pi:
                angle_diff -= 2*pi
            while angle_diff < -pi:
                angle_diff += 2*pi

            if abs(angle_diff) < self.angle_threshold:
                break

            # Daha hassas dönüş için oransal kontrol
            turn_speed = min(self.turn_speed, max(0.1, abs(angle_diff) * 0.5))
            twist = Twist()
            twist.angular.z = turn_speed if angle_diff > 0 else -turn_speed
            self.cmd_vel_pub.publish(twist)
            rospy.sleep(0.05)

        # Dönüşü tamamla ve dur
        self.stop_robot()

    def move_forward(self, distance):
        start_x = self.robot_x
        start_y = self.robot_y

        while not rospy.is_shutdown():
            current_distance = sqrt((self.robot_x - start_x)**2 + (self.robot_y - start_y)**2)

            if current_distance >= distance:
                break

            twist = Twist()
            twist.linear.x = self.move_speed
            self.cmd_vel_pub.publish(twist)
            rospy.sleep(0.1)

        # Dur
        self.stop_robot()

    def stop_robot(self):
        twist = Twist()
        self.cmd_vel_pub.publish(twist)
        rospy.sleep(0.1)

    def odom_callback(self, msg):
        # Odometry verilerini güncelle
        self.robot_x = msg.pose.pose.position.x
        self.robot_y = msg.pose.pose.position.y

        # Quaternion'dan Euler açısına dönüşüm
        quat = msg.pose.pose.orientation
        self.robot_theta = atan2(2.0*(quat.w*quat.z + quat.x*quat.y),
                               1.0 - 2.0*(quat.y*quat.y + quat.z*quat.z))

    def dfs_exploration(self, start_cell, target_rewards):
        stack = [(start_cell, [])]  # (hücre, path) tuple'ları
        path = []
        found_rewards = 0

        while stack and found_rewards < target_rewards:
            current, current_path = stack.pop()

            if not self.visited[current]:
                self.visited[current] = True
                path.append(current)
                current_path.append(current)

                # Hücreye git
                self.move_to_cell(current)
                rospy.loginfo(f"Visiting cell {current}")

                if self.rewards[current] == 1:
                    found_rewards += 1
                    rospy.loginfo(f"Found reward at cell {current}! Total rewards: {found_rewards}")

                # Komşuları kontrol et
                neighbors = self.get_neighbors(current)

                if not neighbors:
                    rospy.loginfo(f"No unvisited neighbors for cell {current}, backtracking...")
                    if current_path:
                        # Bir önceki hücreye geri dön
                        if len(current_path) > 1:
                            self.move_to_cell(current_path[-2])
                else:
                    rospy.loginfo(f"Found {len(neighbors)} unvisited neighbors for cell {current}")
                    # Komşuları stack'e ekle (DFS için ters sırada)
                    for neighbor in reversed(neighbors):
                        stack.append((neighbor, current_path[:]))

        return path, found_rewards

    def get_neighbors(self, cell):
        """Hücrenin komşularını saat yönünde sırayla kontrol eder (yukarı, sağ, aşağı, sol)"""
        neighbors = []
        # Sırayla yukarı, sağ, aşağı, sol komşuları kontrol et
        directions = [
            (-self.grid_size, 'up'),
            (1, 'right'),
            (self.grid_size, 'down'),
            (-1, 'left')
        ]

        for direction, direction_name in directions:
            neighbor = cell + direction

            # Geçerli bir komşu mu kontrol et
            if (0 <= neighbor < 16 and
                self.adjacency_matrix[cell][neighbor] == 1 and
                not self.visited[neighbor]):

                # Geçerli bir kenar geçişi mi kontrol et
                if direction == 1:  # Sağa hareket
                    if cell % self.grid_size != self.grid_size - 1:
                        neighbors.append(neighbor)
                elif direction == -1:  # Sola hareket
                    if cell % self.grid_size != 0:
                        neighbors.append(neighbor)
                else:  # Yukarı veya aşağı hareket
                    neighbors.append(neighbor)

                rospy.loginfo(f"Found valid neighbor {neighbor} to the {direction_name} of cell {cell}")

        return neighbors

if __name__ == '__main__':
    try:
        explorer = DFSExplorer()
        rospy.sleep(1)  # Sistemin başlaması için bekle

        # İlk deney: 2 ödül bul
        rospy.loginfo("Starting first experiment - Finding 2 rewards")
        path1, rewards1 = explorer.dfs_exploration(0, 2)
        rospy.loginfo(f"First experiment completed. Path: {path1}, Rewards found: {rewards1}")

        # Reset
        explorer.visited = [False] * 16
        explorer.rewards = [0] * 16
        explorer.place_rewards(3)
        rospy.sleep(1)

        # İkinci deney: 3 ödül bul
        rospy.loginfo("Starting second experiment - Finding 3 rewards")
        path2, rewards2 = explorer.dfs_exploration(0, 3)
        rospy.loginfo(f"Second experiment completed. Path: {path2}, Rewards found: {rewards2}")

    except rospy.ROSInterruptException:
        pass