FROM osrf/ros:humble-desktop

ENV DEBIAN_FRONTEND=noninteractive
ENV LANG=C.UTF-8
ENV LC_ALL=C.UTF-8

# Install useful dev tools and colcon
RUN apt-get update && apt-get install -y \
    python3-colcon-common-extensions \
    git curl sudo locales \
    x11-apps xauth \
    && rm -rf /var/lib/apt/lists/*

# Locale setup
RUN locale-gen en_US en_US.UTF-8 && \
    update-locale LC_ALL=en_US.UTF-8 LANG=en_US.UTF-8

# Create user (optional)
RUN useradd -m -s /bin/bash stephen && \
    echo "stephen ALL=(ALL) NOPASSWD:ALL" >> /etc/sudoers

USER stephen
WORKDIR /home/stephen/ros2_ws

# Source ROS on shell start
RUN echo "source /opt/ros/humble/setup.bash" >> /home/stephen/.bashrc

CMD ["bash"]

