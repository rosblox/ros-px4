#!/bin/bash

docker run -it --net=vortex_default --workdir /colcon_ws -v $(pwd)/px4_msgs:/colcon_ws/src/px4_msgs -v $(pwd)/px4_ros_com:/colcon_ws/src/px4_ros_com ghcr.io/rosblox/ros-px4:humble
