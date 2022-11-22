ARG ROS_DISTRO=humble

FROM ros:${ROS_DISTRO}-ros-base

RUN chmod 1777 /tmp

RUN apt update && apt install -y --no-install-recommends python3-colcon-common-extensions ros-humble-control-toolbox && rm -rf /var/lib/apt/lists/*

WORKDIR /colcon_ws/src

COPY px4_msgs px4_msgs
COPY px4_ros_com px4_ros_com

WORKDIR /colcon_ws

RUN . /opt/ros/${ROS_DISTRO}/setup.sh && colcon build --cmake-args -DCMAKE_BUILD_TYPE=RELWITHDEBINFO --symlink-install --event-handlers console_direct+

WORKDIR /

COPY ros_entrypoint.sh .

RUN echo 'alias build="colcon build --cmake-args --symlink-install --packages-skip px4_msgs --event-handlers console_direct+"' >> ~/.bashrc
RUN echo 'alias run="ros2 run px4_ros_com offboard_control"' >> ~/.bashrc
