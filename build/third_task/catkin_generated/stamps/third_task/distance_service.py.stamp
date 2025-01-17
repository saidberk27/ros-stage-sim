#!/usr/bin/env python3

import rospy
import math
from third_task.srv import Distance, DistanceResponse

def calculate_distance(req):
    distance = math.sqrt((req.x2 - req.x1)**2 + (req.y2 - req.y1)**2)
    return DistanceResponse(distance)

def distance_server():
    rospy.init_node('distance_service')
    s = rospy.Service('calculate_distance', Distance, calculate_distance)
    rospy.loginfo("Distance calculation service is ready")
    rospy.spin()

if __name__ == "__main__":
    distance_server()