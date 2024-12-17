# Base Image: Ubuntu 22.04
FROM ubuntu:22.04

# Install necessary tools and services
RUN apt-get update && \
    apt-get install -y openssh-server apache2 mariadb-server sudo iptables && \
    apt-get clean

# Set up SSH
RUN mkdir /var/run/sshd && ssh-keygen -A

# Add users with different privilege levels
RUN useradd -m -s /bin/bash admin && echo "admin:adminpassword" | chpasswd && usermod -aG sudo admin && \
    useradd -m -s /bin/bash support && echo "support:supportpassword" | chpasswd && \
    useradd -m -s /bin/bash user1 && echo "user1:userpassword" | chpasswd

# Allow password login for SSH
RUN sed -i 's/#PermitRootLogin prohibit-password/PermitRootLogin yes/' /etc/ssh/sshd_config && \
    sed -i 's/#PasswordAuthentication yes/PasswordAuthentication yes/' /etc/ssh/sshd_config

# Expose ports for SSH and Apache
EXPOSE 22 80

# Copy the breaking script into the container
COPY break_env.sh /usr/local/bin/break_env.sh
RUN chmod +x /usr/local/bin/break_env.sh

# Start SSH and run the breaking script
CMD service ssh start && bash /usr/local/bin/break_env.sh && tail -f /dev/null