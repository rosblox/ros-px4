# Copyright 2016 Open Source Robotics Foundation, Inc.
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

import rclpy
from rclpy.node import Node

from geometry_msgs.msg import Vector3

mode="swing_and_turn"
# mode="swing"

class MinimalPublisher(Node):

    def __init__(self):
        super().__init__('minimal_publisher')
        self.publisher_ = self.create_publisher(Vector3, 'setpoint', 10)
        timer_period = 0.02  # seconds
        self.timer = self.create_timer(timer_period, self.timer_callback)
        self.i = 0
    
    def i_from_sec(self, seconds: int):
        return seconds*50

    def timer_callback(self):
        
        period = 73

        if mode == "half_turn":
            thrust = 0.7
            duration = 1.0
            speed = 180.0/duration

            start_point = -120.0

            if self.i <= self.i_from_sec(10):
                self.publisher_.publish(Vector3(x=thrust,y=start_point, z=float(self.i)))
            elif self.i <= self.i_from_sec(10) + self.i_from_sec(duration):
                i_start = self.i_from_sec(10)
                y = start_point + (self.i-i_start)/50 * speed
                self.publisher_.publish(Vector3(x=thrust,y=y, z=float(self.i)))

            elif self.i >= self.i_from_sec(10) + self.i_from_sec(duration):
                i_start = self.i_from_sec(10)
                y = start_point + 180
                self.publisher_.publish(Vector3(x=thrust,y=y, z=float(self.i)))
        elif mode == "swing":

            if self.i // period  % 2 == 0:
                thrust = 0.3
            elif self.i // period  % 2 == 1:
                thrust = 0.0

            self.publisher_.publish(Vector3(x=thrust,y=40.0, z=float(self.i)))

        elif mode == "swing_and_turn":

            thrust = 0.3

            if self.i // period  % 2 == 0:
                yaw = 40.0
            elif self.i // period  % 2 == 1:
                yaw = -140.0

            self.publisher_.publish(Vector3(x=thrust,y=yaw, z=float(self.i)))


        self.i += 1


def main(args=None):
    rclpy.init(args=args)

    minimal_publisher = MinimalPublisher()

    rclpy.spin(minimal_publisher)

    # Destroy the node explicitly
    # (optional - otherwise it will be done automatically
    # when the garbage collector destroys the node object)
    minimal_publisher.destroy_node()
    rclpy.shutdown()


if __name__ == '__main__':
    main()
