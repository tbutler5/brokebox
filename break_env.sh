#!/bin/bash
echo "Breaking the environment..."

# Stop Apache and MariaDB
service apache2 stop
service mariadb stop

# Break permissions on critical files
chmod 000 /etc/apache2/apache2.conf
chmod 000 /var/log/apache2/error.log

# Fill up disk space
dd if=/dev/zero of=/tmp/bigfile bs=1M count=512 || true

# Block HTTP traffic
iptables -A INPUT -p tcp --dport 80 -j DROP

# Corrupt DNS resolution
echo "# Broken DNS" > /etc/resolv.conf

echo "Environment broken. Log in as a user to start fixing!"