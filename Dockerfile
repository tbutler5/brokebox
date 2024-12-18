FROM ubuntu:20.04

# Prevent interactive prompts
ENV DEBIAN_FRONTEND=noninteractive

# Install services and tools
RUN apt-get update && \
    apt-get install -y apache2 mariadb-server sudo iptables && \
    apt-get clean

# Add users with passwords
RUN useradd -m -s /bin/bash admin && echo "admin:adminpassword" | chpasswd && usermod -aG sudo admin && \
    useradd -m -s /bin/bash support && echo "support:supportpassword" | chpasswd && \
    useradd -m -s /bin/bash user1 && echo "user1:userpassword" | chpasswd

# Copy the break script
COPY break_env.sh /usr/local/bin/break_env.sh
RUN chmod +x /usr/local/bin/break_env.sh

# Prepare SSH
RUN apt-get install -y openssh-server && \
    mkdir /var/run/sshd

# Expose SSH and HTTP ports
EXPOSE 22 80

# Run SSH and start breaking script
CMD service ssh start && bash /usr/local/bin/break_env.sh && tail -f /dev/null
