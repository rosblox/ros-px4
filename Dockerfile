ARG ROS_DISTRO=humble

FROM ros:${ROS_DISTRO}-ros-base

RUN apt update && apt install -y --no-install-recommends python3-colcon-common-extensions && rm -rf /var/lib/apt/lists/*

WORKDIR /colcon_ws/src

RUN git clone --single-branch --depth 1 https://github.com/rosblox/px4_msgs.git 
RUN git clone --single-branch --depth 1 https://github.com/rosblox/px4_ros_com.git 

WORKDIR /colcon_ws

RUN . /opt/ros/${ROS_DISTRO}/setup.sh && colcon build --cmake-args -DCMAKE_BUILD_TYPE=RELWITHDEBINFO --symlink-install --event-handlers console_direct+

WORKDIR /

COPY ros_entrypoint.sh .
