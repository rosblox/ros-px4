ARG ROS_DISTRO=humble

FROM ros:${ROS_DISTRO}-ros-base

RUN apt update && apt install -y --no-install-recommends python3-colcon-common-extensions && rm -rf /var/lib/apt/lists/*

WORKDIR /colcon_ws/src

COPY px4_msgs px4_msgs
COPY px4_ros_com px4_ros_com

WORKDIR /colcon_ws

RUN . /opt/ros/${ROS_DISTRO}/setup.sh && colcon build --cmake-args -DCMAKE_BUILD_TYPE=RELWITHDEBINFO --symlink-install --event-handlers console_direct+

WORKDIR /

COPY ros_entrypoint.sh .
