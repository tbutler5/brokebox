
# Broke Box Troubleshooting Exercise

## Directory Structure:
Your `brokebox` directory should have the following files:
- **Dockerfile**: Builds the Docker container with users and services.
- **break_env.sh**: Script that intentionally breaks the environment at runtime.
- **brokebox_assignment.txt**: Instructions, tasks, and solutions.

## Setup Instructions:
Follow these steps to set up the Broke Box environment.

1. **Navigate to the Broke Box directory**:
   ```bash
   cd brokebox
   ```

2. **Build the Docker image**:
   ```bash
   docker build -t broke-box .
   ```

3. **Start the container with the appropriate privileges**:
   ```bash
   docker run --privileged -d --name broke-box -p 2222:22 broke-box
   ```

4. **Log in to the container as different users via SSH**.

- **Log in as admin**:
   ```bash
   ssh admin@localhost -p 2222
   ```
   **Password**: `adminpassword`

- **Log in as support**:
   ```bash
   ssh support@localhost -p 2222
   ```
   **Password**: `supportpassword`

- **Log in as user1**:
   ```bash
   ssh user1@localhost -p 2222
   ```
   **Password**: `userpassword`

---

## Tasks:

### Task 1: Fix Apache Configuration
**Problem**: Apache web server is not running. Permissions on the file `/etc/apache2/apache2.conf` are incorrect.

### Task 2: Fix Disk Space Issue
**Problem**: The `/tmp` directory contains a large file named `/tmp/bigfile` which is consuming disk space.

### Task 3: Fix Broken DNS
**Problem**: DNS resolution is broken because the file `/etc/resolv.conf` is corrupted.

### Task 4: Fix Blocked HTTP Traffic
**Problem**: HTTP traffic is blocked due to `iptables` firewall rules.

### Task 5: Check File Permissions
**Problem**: The file `/etc/passwd` has incorrect permissions preventing proper access.

---

## Solutions:

### Task 1: Fix Apache Configuration
- **Log in as support**.
- Fix file permissions:
   ```bash
   sudo chmod 644 /etc/apache2/apache2.conf
   ```
- Restart Apache:
   ```bash
   sudo service apache2 start
   ```

### Task 2: Fix Disk Space Issue
- **Log in as admin**.
- Identify the large file:
   ```bash
   ls -lh /tmp
   ```
- Remove the file:
   ```bash
   rm /tmp/bigfile
   ```

### Task 3: Fix Broken DNS
- **Log in as admin**.
- Fix DNS configuration:
   ```bash
   echo "nameserver 8.8.8.8" > /etc/resolv.conf
   ```

### Task 4: Fix Blocked HTTP Traffic
- **Log in as support**.
- Flush the `iptables` rules:
   ```bash
   sudo iptables -F
   ```

### Task 5: Check File Permissions
- **Log in as admin**.
- Fix file permissions:
   ```bash
   chmod 644 /etc/passwd
   ```

---

## Conclusion:
Congratulations. You have successfully completed the Broke Box troubleshooting exercise.
