cmake_minimum_required(VERSION 3.0.2)
project(third_task)

find_package(catkin REQUIRED COMPONENTS
  rospy
  std_msgs
  geometry_msgs
  nav_msgs
  message_generation
)

## Mesaj ve servis tanımlamaları buraya gelmelidir (find_package'den sonra, catkin_package'den önce)
add_message_files(
  FILES
  Coordinates.msg
)

add_service_files(
  FILES
  Distance.srv
)

generate_messages(
  DEPENDENCIES
  std_msgs
)

catkin_package(
  CATKIN_DEPENDS 
    rospy 
    std_msgs 
    geometry_msgs 
    nav_msgs 
    message_runtime
)

include_directories(
  ${catkin_INCLUDE_DIRS}
)

catkin_install_python(PROGRAMS
  scripts/distance_service.py
  scripts/position_publisher.py
  scripts/modified_pointop.py
  DESTINATION ${CATKIN_PACKAGE_BIN_DESTINATION}
)