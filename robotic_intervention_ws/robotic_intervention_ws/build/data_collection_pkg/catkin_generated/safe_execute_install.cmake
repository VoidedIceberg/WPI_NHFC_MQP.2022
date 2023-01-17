execute_process(COMMAND "/home/rohit/robotic_intervention_ws/build/data_collection_pkg/catkin_generated/python_distutils_install.sh" RESULT_VARIABLE res)

if(NOT res EQUAL 0)
  message(FATAL_ERROR "execute_process(/home/rohit/robotic_intervention_ws/build/data_collection_pkg/catkin_generated/python_distutils_install.sh) returned error code ")
endif()
