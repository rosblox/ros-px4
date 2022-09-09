#!/bin/bash

#docker run -it --privileged  -v /dev/shm:/dev/shm --shm-size=256m --net=host -v $(pwd)/px4_msgs:/colcon_ws/src/px4_msgs -v $(pwd)/px4_ros_com:/colcon_ws/src/px4_ros_com ghcr.io/rosblox/ros-px4:humble
docker run -it -v $(pwd)/px4_msgs:/colcon_ws/src/px4_msgs -v $(pwd)/px4_ros_com:/colcon_ws/src/px4_ros_com ghcr.io/rosblox/ros-px4:humble
