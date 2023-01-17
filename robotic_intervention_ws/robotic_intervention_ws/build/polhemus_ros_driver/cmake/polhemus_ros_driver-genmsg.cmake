# generated from genmsg/cmake/pkg-genmsg.cmake.em

message(STATUS "polhemus_ros_driver: 0 messages, 3 services")

set(MSG_I_FLAGS "-Istd_msgs:/opt/ros/noetic/share/std_msgs/cmake/../msg")

# Find all generators
find_package(gencpp REQUIRED)
find_package(geneus REQUIRED)
find_package(genlisp REQUIRED)
find_package(gennodejs REQUIRED)
find_package(genpy REQUIRED)

add_custom_target(polhemus_ros_driver_generate_messages ALL)

# verify that message/service dependencies have not changed since configure



get_filename_component(_filename "/home/rohit/robotic_intervention_ws/src/polhemus_ros_driver/srv/calibrate.srv" NAME_WE)
add_custom_target(_polhemus_ros_driver_generate_messages_check_deps_${_filename}
  COMMAND ${CATKIN_ENV} ${PYTHON_EXECUTABLE} ${GENMSG_CHECK_DEPS_SCRIPT} "polhemus_ros_driver" "/home/rohit/robotic_intervention_ws/src/polhemus_ros_driver/srv/calibrate.srv" ""
)

get_filename_component(_filename "/home/rohit/robotic_intervention_ws/src/polhemus_ros_driver/srv/set_source.srv" NAME_WE)
add_custom_target(_polhemus_ros_driver_generate_messages_check_deps_${_filename}
  COMMAND ${CATKIN_ENV} ${PYTHON_EXECUTABLE} ${GENMSG_CHECK_DEPS_SCRIPT} "polhemus_ros_driver" "/home/rohit/robotic_intervention_ws/src/polhemus_ros_driver/srv/set_source.srv" ""
)

get_filename_component(_filename "/home/rohit/robotic_intervention_ws/src/polhemus_ros_driver/srv/persist.srv" NAME_WE)
add_custom_target(_polhemus_ros_driver_generate_messages_check_deps_${_filename}
  COMMAND ${CATKIN_ENV} ${PYTHON_EXECUTABLE} ${GENMSG_CHECK_DEPS_SCRIPT} "polhemus_ros_driver" "/home/rohit/robotic_intervention_ws/src/polhemus_ros_driver/srv/persist.srv" ""
)

#
#  langs = gencpp;geneus;genlisp;gennodejs;genpy
#

### Section generating for lang: gencpp
### Generating Messages

### Generating Services
_generate_srv_cpp(polhemus_ros_driver
  "/home/rohit/robotic_intervention_ws/src/polhemus_ros_driver/srv/calibrate.srv"
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${gencpp_INSTALL_DIR}/polhemus_ros_driver
)
_generate_srv_cpp(polhemus_ros_driver
  "/home/rohit/robotic_intervention_ws/src/polhemus_ros_driver/srv/set_source.srv"
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${gencpp_INSTALL_DIR}/polhemus_ros_driver
)
_generate_srv_cpp(polhemus_ros_driver
  "/home/rohit/robotic_intervention_ws/src/polhemus_ros_driver/srv/persist.srv"
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${gencpp_INSTALL_DIR}/polhemus_ros_driver
)

### Generating Module File
_generate_module_cpp(polhemus_ros_driver
  ${CATKIN_DEVEL_PREFIX}/${gencpp_INSTALL_DIR}/polhemus_ros_driver
  "${ALL_GEN_OUTPUT_FILES_cpp}"
)

add_custom_target(polhemus_ros_driver_generate_messages_cpp
  DEPENDS ${ALL_GEN_OUTPUT_FILES_cpp}
)
add_dependencies(polhemus_ros_driver_generate_messages polhemus_ros_driver_generate_messages_cpp)

# add dependencies to all check dependencies targets
get_filename_component(_filename "/home/rohit/robotic_intervention_ws/src/polhemus_ros_driver/srv/calibrate.srv" NAME_WE)
add_dependencies(polhemus_ros_driver_generate_messages_cpp _polhemus_ros_driver_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/rohit/robotic_intervention_ws/src/polhemus_ros_driver/srv/set_source.srv" NAME_WE)
add_dependencies(polhemus_ros_driver_generate_messages_cpp _polhemus_ros_driver_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/rohit/robotic_intervention_ws/src/polhemus_ros_driver/srv/persist.srv" NAME_WE)
add_dependencies(polhemus_ros_driver_generate_messages_cpp _polhemus_ros_driver_generate_messages_check_deps_${_filename})

# target for backward compatibility
add_custom_target(polhemus_ros_driver_gencpp)
add_dependencies(polhemus_ros_driver_gencpp polhemus_ros_driver_generate_messages_cpp)

# register target for catkin_package(EXPORTED_TARGETS)
list(APPEND ${PROJECT_NAME}_EXPORTED_TARGETS polhemus_ros_driver_generate_messages_cpp)

### Section generating for lang: geneus
### Generating Messages

### Generating Services
_generate_srv_eus(polhemus_ros_driver
  "/home/rohit/robotic_intervention_ws/src/polhemus_ros_driver/srv/calibrate.srv"
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${geneus_INSTALL_DIR}/polhemus_ros_driver
)
_generate_srv_eus(polhemus_ros_driver
  "/home/rohit/robotic_intervention_ws/src/polhemus_ros_driver/srv/set_source.srv"
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${geneus_INSTALL_DIR}/polhemus_ros_driver
)
_generate_srv_eus(polhemus_ros_driver
  "/home/rohit/robotic_intervention_ws/src/polhemus_ros_driver/srv/persist.srv"
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${geneus_INSTALL_DIR}/polhemus_ros_driver
)

### Generating Module File
_generate_module_eus(polhemus_ros_driver
  ${CATKIN_DEVEL_PREFIX}/${geneus_INSTALL_DIR}/polhemus_ros_driver
  "${ALL_GEN_OUTPUT_FILES_eus}"
)

add_custom_target(polhemus_ros_driver_generate_messages_eus
  DEPENDS ${ALL_GEN_OUTPUT_FILES_eus}
)
add_dependencies(polhemus_ros_driver_generate_messages polhemus_ros_driver_generate_messages_eus)

# add dependencies to all check dependencies targets
get_filename_component(_filename "/home/rohit/robotic_intervention_ws/src/polhemus_ros_driver/srv/calibrate.srv" NAME_WE)
add_dependencies(polhemus_ros_driver_generate_messages_eus _polhemus_ros_driver_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/rohit/robotic_intervention_ws/src/polhemus_ros_driver/srv/set_source.srv" NAME_WE)
add_dependencies(polhemus_ros_driver_generate_messages_eus _polhemus_ros_driver_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/rohit/robotic_intervention_ws/src/polhemus_ros_driver/srv/persist.srv" NAME_WE)
add_dependencies(polhemus_ros_driver_generate_messages_eus _polhemus_ros_driver_generate_messages_check_deps_${_filename})

# target for backward compatibility
add_custom_target(polhemus_ros_driver_geneus)
add_dependencies(polhemus_ros_driver_geneus polhemus_ros_driver_generate_messages_eus)

# register target for catkin_package(EXPORTED_TARGETS)
list(APPEND ${PROJECT_NAME}_EXPORTED_TARGETS polhemus_ros_driver_generate_messages_eus)

### Section generating for lang: genlisp
### Generating Messages

### Generating Services
_generate_srv_lisp(polhemus_ros_driver
  "/home/rohit/robotic_intervention_ws/src/polhemus_ros_driver/srv/calibrate.srv"
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${genlisp_INSTALL_DIR}/polhemus_ros_driver
)
_generate_srv_lisp(polhemus_ros_driver
  "/home/rohit/robotic_intervention_ws/src/polhemus_ros_driver/srv/set_source.srv"
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${genlisp_INSTALL_DIR}/polhemus_ros_driver
)
_generate_srv_lisp(polhemus_ros_driver
  "/home/rohit/robotic_intervention_ws/src/polhemus_ros_driver/srv/persist.srv"
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${genlisp_INSTALL_DIR}/polhemus_ros_driver
)

### Generating Module File
_generate_module_lisp(polhemus_ros_driver
  ${CATKIN_DEVEL_PREFIX}/${genlisp_INSTALL_DIR}/polhemus_ros_driver
  "${ALL_GEN_OUTPUT_FILES_lisp}"
)

add_custom_target(polhemus_ros_driver_generate_messages_lisp
  DEPENDS ${ALL_GEN_OUTPUT_FILES_lisp}
)
add_dependencies(polhemus_ros_driver_generate_messages polhemus_ros_driver_generate_messages_lisp)

# add dependencies to all check dependencies targets
get_filename_component(_filename "/home/rohit/robotic_intervention_ws/src/polhemus_ros_driver/srv/calibrate.srv" NAME_WE)
add_dependencies(polhemus_ros_driver_generate_messages_lisp _polhemus_ros_driver_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/rohit/robotic_intervention_ws/src/polhemus_ros_driver/srv/set_source.srv" NAME_WE)
add_dependencies(polhemus_ros_driver_generate_messages_lisp _polhemus_ros_driver_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/rohit/robotic_intervention_ws/src/polhemus_ros_driver/srv/persist.srv" NAME_WE)
add_dependencies(polhemus_ros_driver_generate_messages_lisp _polhemus_ros_driver_generate_messages_check_deps_${_filename})

# target for backward compatibility
add_custom_target(polhemus_ros_driver_genlisp)
add_dependencies(polhemus_ros_driver_genlisp polhemus_ros_driver_generate_messages_lisp)

# register target for catkin_package(EXPORTED_TARGETS)
list(APPEND ${PROJECT_NAME}_EXPORTED_TARGETS polhemus_ros_driver_generate_messages_lisp)

### Section generating for lang: gennodejs
### Generating Messages

### Generating Services
_generate_srv_nodejs(polhemus_ros_driver
  "/home/rohit/robotic_intervention_ws/src/polhemus_ros_driver/srv/calibrate.srv"
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${gennodejs_INSTALL_DIR}/polhemus_ros_driver
)
_generate_srv_nodejs(polhemus_ros_driver
  "/home/rohit/robotic_intervention_ws/src/polhemus_ros_driver/srv/set_source.srv"
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${gennodejs_INSTALL_DIR}/polhemus_ros_driver
)
_generate_srv_nodejs(polhemus_ros_driver
  "/home/rohit/robotic_intervention_ws/src/polhemus_ros_driver/srv/persist.srv"
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${gennodejs_INSTALL_DIR}/polhemus_ros_driver
)

### Generating Module File
_generate_module_nodejs(polhemus_ros_driver
  ${CATKIN_DEVEL_PREFIX}/${gennodejs_INSTALL_DIR}/polhemus_ros_driver
  "${ALL_GEN_OUTPUT_FILES_nodejs}"
)

add_custom_target(polhemus_ros_driver_generate_messages_nodejs
  DEPENDS ${ALL_GEN_OUTPUT_FILES_nodejs}
)
add_dependencies(polhemus_ros_driver_generate_messages polhemus_ros_driver_generate_messages_nodejs)

# add dependencies to all check dependencies targets
get_filename_component(_filename "/home/rohit/robotic_intervention_ws/src/polhemus_ros_driver/srv/calibrate.srv" NAME_WE)
add_dependencies(polhemus_ros_driver_generate_messages_nodejs _polhemus_ros_driver_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/rohit/robotic_intervention_ws/src/polhemus_ros_driver/srv/set_source.srv" NAME_WE)
add_dependencies(polhemus_ros_driver_generate_messages_nodejs _polhemus_ros_driver_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/rohit/robotic_intervention_ws/src/polhemus_ros_driver/srv/persist.srv" NAME_WE)
add_dependencies(polhemus_ros_driver_generate_messages_nodejs _polhemus_ros_driver_generate_messages_check_deps_${_filename})

# target for backward compatibility
add_custom_target(polhemus_ros_driver_gennodejs)
add_dependencies(polhemus_ros_driver_gennodejs polhemus_ros_driver_generate_messages_nodejs)

# register target for catkin_package(EXPORTED_TARGETS)
list(APPEND ${PROJECT_NAME}_EXPORTED_TARGETS polhemus_ros_driver_generate_messages_nodejs)

### Section generating for lang: genpy
### Generating Messages

### Generating Services
_generate_srv_py(polhemus_ros_driver
  "/home/rohit/robotic_intervention_ws/src/polhemus_ros_driver/srv/calibrate.srv"
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${genpy_INSTALL_DIR}/polhemus_ros_driver
)
_generate_srv_py(polhemus_ros_driver
  "/home/rohit/robotic_intervention_ws/src/polhemus_ros_driver/srv/set_source.srv"
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${genpy_INSTALL_DIR}/polhemus_ros_driver
)
_generate_srv_py(polhemus_ros_driver
  "/home/rohit/robotic_intervention_ws/src/polhemus_ros_driver/srv/persist.srv"
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${genpy_INSTALL_DIR}/polhemus_ros_driver
)

### Generating Module File
_generate_module_py(polhemus_ros_driver
  ${CATKIN_DEVEL_PREFIX}/${genpy_INSTALL_DIR}/polhemus_ros_driver
  "${ALL_GEN_OUTPUT_FILES_py}"
)

add_custom_target(polhemus_ros_driver_generate_messages_py
  DEPENDS ${ALL_GEN_OUTPUT_FILES_py}
)
add_dependencies(polhemus_ros_driver_generate_messages polhemus_ros_driver_generate_messages_py)

# add dependencies to all check dependencies targets
get_filename_component(_filename "/home/rohit/robotic_intervention_ws/src/polhemus_ros_driver/srv/calibrate.srv" NAME_WE)
add_dependencies(polhemus_ros_driver_generate_messages_py _polhemus_ros_driver_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/rohit/robotic_intervention_ws/src/polhemus_ros_driver/srv/set_source.srv" NAME_WE)
add_dependencies(polhemus_ros_driver_generate_messages_py _polhemus_ros_driver_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/rohit/robotic_intervention_ws/src/polhemus_ros_driver/srv/persist.srv" NAME_WE)
add_dependencies(polhemus_ros_driver_generate_messages_py _polhemus_ros_driver_generate_messages_check_deps_${_filename})

# target for backward compatibility
add_custom_target(polhemus_ros_driver_genpy)
add_dependencies(polhemus_ros_driver_genpy polhemus_ros_driver_generate_messages_py)

# register target for catkin_package(EXPORTED_TARGETS)
list(APPEND ${PROJECT_NAME}_EXPORTED_TARGETS polhemus_ros_driver_generate_messages_py)



if(gencpp_INSTALL_DIR AND EXISTS ${CATKIN_DEVEL_PREFIX}/${gencpp_INSTALL_DIR}/polhemus_ros_driver)
  # install generated code
  install(
    DIRECTORY ${CATKIN_DEVEL_PREFIX}/${gencpp_INSTALL_DIR}/polhemus_ros_driver
    DESTINATION ${gencpp_INSTALL_DIR}
  )
endif()
if(TARGET std_msgs_generate_messages_cpp)
  add_dependencies(polhemus_ros_driver_generate_messages_cpp std_msgs_generate_messages_cpp)
endif()

if(geneus_INSTALL_DIR AND EXISTS ${CATKIN_DEVEL_PREFIX}/${geneus_INSTALL_DIR}/polhemus_ros_driver)
  # install generated code
  install(
    DIRECTORY ${CATKIN_DEVEL_PREFIX}/${geneus_INSTALL_DIR}/polhemus_ros_driver
    DESTINATION ${geneus_INSTALL_DIR}
  )
endif()
if(TARGET std_msgs_generate_messages_eus)
  add_dependencies(polhemus_ros_driver_generate_messages_eus std_msgs_generate_messages_eus)
endif()

if(genlisp_INSTALL_DIR AND EXISTS ${CATKIN_DEVEL_PREFIX}/${genlisp_INSTALL_DIR}/polhemus_ros_driver)
  # install generated code
  install(
    DIRECTORY ${CATKIN_DEVEL_PREFIX}/${genlisp_INSTALL_DIR}/polhemus_ros_driver
    DESTINATION ${genlisp_INSTALL_DIR}
  )
endif()
if(TARGET std_msgs_generate_messages_lisp)
  add_dependencies(polhemus_ros_driver_generate_messages_lisp std_msgs_generate_messages_lisp)
endif()

if(gennodejs_INSTALL_DIR AND EXISTS ${CATKIN_DEVEL_PREFIX}/${gennodejs_INSTALL_DIR}/polhemus_ros_driver)
  # install generated code
  install(
    DIRECTORY ${CATKIN_DEVEL_PREFIX}/${gennodejs_INSTALL_DIR}/polhemus_ros_driver
    DESTINATION ${gennodejs_INSTALL_DIR}
  )
endif()
if(TARGET std_msgs_generate_messages_nodejs)
  add_dependencies(polhemus_ros_driver_generate_messages_nodejs std_msgs_generate_messages_nodejs)
endif()

if(genpy_INSTALL_DIR AND EXISTS ${CATKIN_DEVEL_PREFIX}/${genpy_INSTALL_DIR}/polhemus_ros_driver)
  install(CODE "execute_process(COMMAND \"/usr/bin/python3\" -m compileall \"${CATKIN_DEVEL_PREFIX}/${genpy_INSTALL_DIR}/polhemus_ros_driver\")")
  # install generated code
  install(
    DIRECTORY ${CATKIN_DEVEL_PREFIX}/${genpy_INSTALL_DIR}/polhemus_ros_driver
    DESTINATION ${genpy_INSTALL_DIR}
    # skip all init files
    PATTERN "__init__.py" EXCLUDE
    PATTERN "__init__.pyc" EXCLUDE
  )
  # install init files which are not in the root folder of the generated code
  string(REGEX REPLACE "([][+.*()^])" "\\\\\\1" ESCAPED_PATH "${CATKIN_DEVEL_PREFIX}/${genpy_INSTALL_DIR}/polhemus_ros_driver")
  install(
    DIRECTORY ${CATKIN_DEVEL_PREFIX}/${genpy_INSTALL_DIR}/polhemus_ros_driver
    DESTINATION ${genpy_INSTALL_DIR}
    FILES_MATCHING
    REGEX "${ESCAPED_PATH}/.+/__init__.pyc?$"
  )
endif()
if(TARGET std_msgs_generate_messages_py)
  add_dependencies(polhemus_ros_driver_generate_messages_py std_msgs_generate_messages_py)
endif()
