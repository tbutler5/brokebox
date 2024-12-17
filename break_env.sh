#!/bin/bash
echo "Breaking the environment..."

# Stop services
service apache2 stop
service mysql stop

# Break permissions on Apache config
chmod 000 /etc/apache2/apache2.conf

# Corrupt DNS resolution
echo "# Broken DNS" > /etc/resolv.conf

# Fill up disk space
dd if=/dev/zero of=/tmp/bigfile bs=1M count=512 || true

# Block HTTP traffic with iptables
iptables -A INPUT -p tcp --dport 80 -j DROP

# Restrict access to Apache error log
chmod 000 /var/log/apache2/error.log

echo "Environment broken. Log in as a user to start fixing!"