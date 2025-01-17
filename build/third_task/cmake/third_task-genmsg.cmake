# generated from genmsg/cmake/pkg-genmsg.cmake.em

message(STATUS "third_task: 1 messages, 1 services")

set(MSG_I_FLAGS "-Ithird_task:/home/saidberk/catkin_ws/src/third_task/msg;-Istd_msgs:/opt/ros/noetic/share/std_msgs/cmake/../msg")

# Find all generators
find_package(gencpp REQUIRED)
find_package(geneus REQUIRED)
find_package(genlisp REQUIRED)
find_package(gennodejs REQUIRED)
find_package(genpy REQUIRED)

add_custom_target(third_task_generate_messages ALL)

# verify that message/service dependencies have not changed since configure



get_filename_component(_filename "/home/saidberk/catkin_ws/src/third_task/msg/Coordinates.msg" NAME_WE)
add_custom_target(_third_task_generate_messages_check_deps_${_filename}
  COMMAND ${CATKIN_ENV} ${PYTHON_EXECUTABLE} ${GENMSG_CHECK_DEPS_SCRIPT} "third_task" "/home/saidberk/catkin_ws/src/third_task/msg/Coordinates.msg" ""
)

get_filename_component(_filename "/home/saidberk/catkin_ws/src/third_task/srv/Distance.srv" NAME_WE)
add_custom_target(_third_task_generate_messages_check_deps_${_filename}
  COMMAND ${CATKIN_ENV} ${PYTHON_EXECUTABLE} ${GENMSG_CHECK_DEPS_SCRIPT} "third_task" "/home/saidberk/catkin_ws/src/third_task/srv/Distance.srv" ""
)

#
#  langs = gencpp;geneus;genlisp;gennodejs;genpy
#

### Section generating for lang: gencpp
### Generating Messages
_generate_msg_cpp(third_task
  "/home/saidberk/catkin_ws/src/third_task/msg/Coordinates.msg"
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${gencpp_INSTALL_DIR}/third_task
)

### Generating Services
_generate_srv_cpp(third_task
  "/home/saidberk/catkin_ws/src/third_task/srv/Distance.srv"
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${gencpp_INSTALL_DIR}/third_task
)

### Generating Module File
_generate_module_cpp(third_task
  ${CATKIN_DEVEL_PREFIX}/${gencpp_INSTALL_DIR}/third_task
  "${ALL_GEN_OUTPUT_FILES_cpp}"
)

add_custom_target(third_task_generate_messages_cpp
  DEPENDS ${ALL_GEN_OUTPUT_FILES_cpp}
)
add_dependencies(third_task_generate_messages third_task_generate_messages_cpp)

# add dependencies to all check dependencies targets
get_filename_component(_filename "/home/saidberk/catkin_ws/src/third_task/msg/Coordinates.msg" NAME_WE)
add_dependencies(third_task_generate_messages_cpp _third_task_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/saidberk/catkin_ws/src/third_task/srv/Distance.srv" NAME_WE)
add_dependencies(third_task_generate_messages_cpp _third_task_generate_messages_check_deps_${_filename})

# target for backward compatibility
add_custom_target(third_task_gencpp)
add_dependencies(third_task_gencpp third_task_generate_messages_cpp)

# register target for catkin_package(EXPORTED_TARGETS)
list(APPEND ${PROJECT_NAME}_EXPORTED_TARGETS third_task_generate_messages_cpp)

### Section generating for lang: geneus
### Generating Messages
_generate_msg_eus(third_task
  "/home/saidberk/catkin_ws/src/third_task/msg/Coordinates.msg"
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${geneus_INSTALL_DIR}/third_task
)

### Generating Services
_generate_srv_eus(third_task
  "/home/saidberk/catkin_ws/src/third_task/srv/Distance.srv"
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${geneus_INSTALL_DIR}/third_task
)

### Generating Module File
_generate_module_eus(third_task
  ${CATKIN_DEVEL_PREFIX}/${geneus_INSTALL_DIR}/third_task
  "${ALL_GEN_OUTPUT_FILES_eus}"
)

add_custom_target(third_task_generate_messages_eus
  DEPENDS ${ALL_GEN_OUTPUT_FILES_eus}
)
add_dependencies(third_task_generate_messages third_task_generate_messages_eus)

# add dependencies to all check dependencies targets
get_filename_component(_filename "/home/saidberk/catkin_ws/src/third_task/msg/Coordinates.msg" NAME_WE)
add_dependencies(third_task_generate_messages_eus _third_task_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/saidberk/catkin_ws/src/third_task/srv/Distance.srv" NAME_WE)
add_dependencies(third_task_generate_messages_eus _third_task_generate_messages_check_deps_${_filename})

# target for backward compatibility
add_custom_target(third_task_geneus)
add_dependencies(third_task_geneus third_task_generate_messages_eus)

# register target for catkin_package(EXPORTED_TARGETS)
list(APPEND ${PROJECT_NAME}_EXPORTED_TARGETS third_task_generate_messages_eus)

### Section generating for lang: genlisp
### Generating Messages
_generate_msg_lisp(third_task
  "/home/saidberk/catkin_ws/src/third_task/msg/Coordinates.msg"
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${genlisp_INSTALL_DIR}/third_task
)

### Generating Services
_generate_srv_lisp(third_task
  "/home/saidberk/catkin_ws/src/third_task/srv/Distance.srv"
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${genlisp_INSTALL_DIR}/third_task
)

### Generating Module File
_generate_module_lisp(third_task
  ${CATKIN_DEVEL_PREFIX}/${genlisp_INSTALL_DIR}/third_task
  "${ALL_GEN_OUTPUT_FILES_lisp}"
)

add_custom_target(third_task_generate_messages_lisp
  DEPENDS ${ALL_GEN_OUTPUT_FILES_lisp}
)
add_dependencies(third_task_generate_messages third_task_generate_messages_lisp)

# add dependencies to all check dependencies targets
get_filename_component(_filename "/home/saidberk/catkin_ws/src/third_task/msg/Coordinates.msg" NAME_WE)
add_dependencies(third_task_generate_messages_lisp _third_task_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/saidberk/catkin_ws/src/third_task/srv/Distance.srv" NAME_WE)
add_dependencies(third_task_generate_messages_lisp _third_task_generate_messages_check_deps_${_filename})

# target for backward compatibility
add_custom_target(third_task_genlisp)
add_dependencies(third_task_genlisp third_task_generate_messages_lisp)

# register target for catkin_package(EXPORTED_TARGETS)
list(APPEND ${PROJECT_NAME}_EXPORTED_TARGETS third_task_generate_messages_lisp)

### Section generating for lang: gennodejs
### Generating Messages
_generate_msg_nodejs(third_task
  "/home/saidberk/catkin_ws/src/third_task/msg/Coordinates.msg"
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${gennodejs_INSTALL_DIR}/third_task
)

### Generating Services
_generate_srv_nodejs(third_task
  "/home/saidberk/catkin_ws/src/third_task/srv/Distance.srv"
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${gennodejs_INSTALL_DIR}/third_task
)

### Generating Module File
_generate_module_nodejs(third_task
  ${CATKIN_DEVEL_PREFIX}/${gennodejs_INSTALL_DIR}/third_task
  "${ALL_GEN_OUTPUT_FILES_nodejs}"
)

add_custom_target(third_task_generate_messages_nodejs
  DEPENDS ${ALL_GEN_OUTPUT_FILES_nodejs}
)
add_dependencies(third_task_generate_messages third_task_generate_messages_nodejs)

# add dependencies to all check dependencies targets
get_filename_component(_filename "/home/saidberk/catkin_ws/src/third_task/msg/Coordinates.msg" NAME_WE)
add_dependencies(third_task_generate_messages_nodejs _third_task_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/saidberk/catkin_ws/src/third_task/srv/Distance.srv" NAME_WE)
add_dependencies(third_task_generate_messages_nodejs _third_task_generate_messages_check_deps_${_filename})

# target for backward compatibility
add_custom_target(third_task_gennodejs)
add_dependencies(third_task_gennodejs third_task_generate_messages_nodejs)

# register target for catkin_package(EXPORTED_TARGETS)
list(APPEND ${PROJECT_NAME}_EXPORTED_TARGETS third_task_generate_messages_nodejs)

### Section generating for lang: genpy
### Generating Messages
_generate_msg_py(third_task
  "/home/saidberk/catkin_ws/src/third_task/msg/Coordinates.msg"
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${genpy_INSTALL_DIR}/third_task
)

### Generating Services
_generate_srv_py(third_task
  "/home/saidberk/catkin_ws/src/third_task/srv/Distance.srv"
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${genpy_INSTALL_DIR}/third_task
)

### Generating Module File
_generate_module_py(third_task
  ${CATKIN_DEVEL_PREFIX}/${genpy_INSTALL_DIR}/third_task
  "${ALL_GEN_OUTPUT_FILES_py}"
)

add_custom_target(third_task_generate_messages_py
  DEPENDS ${ALL_GEN_OUTPUT_FILES_py}
)
add_dependencies(third_task_generate_messages third_task_generate_messages_py)

# add dependencies to all check dependencies targets
get_filename_component(_filename "/home/saidberk/catkin_ws/src/third_task/msg/Coordinates.msg" NAME_WE)
add_dependencies(third_task_generate_messages_py _third_task_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/saidberk/catkin_ws/src/third_task/srv/Distance.srv" NAME_WE)
add_dependencies(third_task_generate_messages_py _third_task_generate_messages_check_deps_${_filename})

# target for backward compatibility
add_custom_target(third_task_genpy)
add_dependencies(third_task_genpy third_task_generate_messages_py)

# register target for catkin_package(EXPORTED_TARGETS)
list(APPEND ${PROJECT_NAME}_EXPORTED_TARGETS third_task_generate_messages_py)



if(gencpp_INSTALL_DIR AND EXISTS ${CATKIN_DEVEL_PREFIX}/${gencpp_INSTALL_DIR}/third_task)
  # install generated code
  install(
    DIRECTORY ${CATKIN_DEVEL_PREFIX}/${gencpp_INSTALL_DIR}/third_task
    DESTINATION ${gencpp_INSTALL_DIR}
  )
endif()
if(TARGET std_msgs_generate_messages_cpp)
  add_dependencies(third_task_generate_messages_cpp std_msgs_generate_messages_cpp)
endif()

if(geneus_INSTALL_DIR AND EXISTS ${CATKIN_DEVEL_PREFIX}/${geneus_INSTALL_DIR}/third_task)
  # install generated code
  install(
    DIRECTORY ${CATKIN_DEVEL_PREFIX}/${geneus_INSTALL_DIR}/third_task
    DESTINATION ${geneus_INSTALL_DIR}
  )
endif()
if(TARGET std_msgs_generate_messages_eus)
  add_dependencies(third_task_generate_messages_eus std_msgs_generate_messages_eus)
endif()

if(genlisp_INSTALL_DIR AND EXISTS ${CATKIN_DEVEL_PREFIX}/${genlisp_INSTALL_DIR}/third_task)
  # install generated code
  install(
    DIRECTORY ${CATKIN_DEVEL_PREFIX}/${genlisp_INSTALL_DIR}/third_task
    DESTINATION ${genlisp_INSTALL_DIR}
  )
endif()
if(TARGET std_msgs_generate_messages_lisp)
  add_dependencies(third_task_generate_messages_lisp std_msgs_generate_messages_lisp)
endif()

if(gennodejs_INSTALL_DIR AND EXISTS ${CATKIN_DEVEL_PREFIX}/${gennodejs_INSTALL_DIR}/third_task)
  # install generated code
  install(
    DIRECTORY ${CATKIN_DEVEL_PREFIX}/${gennodejs_INSTALL_DIR}/third_task
    DESTINATION ${gennodejs_INSTALL_DIR}
  )
endif()
if(TARGET std_msgs_generate_messages_nodejs)
  add_dependencies(third_task_generate_messages_nodejs std_msgs_generate_messages_nodejs)
endif()

if(genpy_INSTALL_DIR AND EXISTS ${CATKIN_DEVEL_PREFIX}/${genpy_INSTALL_DIR}/third_task)
  install(CODE "execute_process(COMMAND \"/usr/bin/python3\" -m compileall \"${CATKIN_DEVEL_PREFIX}/${genpy_INSTALL_DIR}/third_task\")")
  # install generated code
  install(
    DIRECTORY ${CATKIN_DEVEL_PREFIX}/${genpy_INSTALL_DIR}/third_task
    DESTINATION ${genpy_INSTALL_DIR}
  )
endif()
if(TARGET std_msgs_generate_messages_py)
  add_dependencies(third_task_generate_messages_py std_msgs_generate_messages_py)
endif()
