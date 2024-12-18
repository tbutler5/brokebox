
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


4. **Log in as admin**:
   ```bash
   ssh admin@localhost -p 2222
   ```
   **Password**: `adminpassword`


---

## Tasks:

### Task 1: Fix Apache Configuration
   #### Check the Apache error log in /var/log/apache2/error.log (fix permissions first).
   #### Identify and fix the broken permissions on /etc/apache2/apache2.conf.
   #### Restart Apache.

### Task 2: Fix DNS Resolution:
   #### Analyze the DNS error logs in /var/log/syslog.
   #### Correct the DNS configuration in /etc/resolv.conf.

### Task 3: Free Disk Space
   #### Identify the large file filling up disk space in /tmp.
   #### Delete the file to free up space.

### Task 4: Unblock HTTP Traffic
   #### Check the iptables rules blocking HTTP traffic on port 80.
   #### Flush the iptables rules.

### Task 5: Verify Fixes:
   #### Apache should be running: Test with 'curl http://localhost'.
   #### DNS should resolve: Test with 'ping google.com'.
   #### Disk space should be cleared: Check with 'df -h'.

---

## Solutions:

### Check logs:
- 
   ```bash
   sudo less /var/log/apache2/error.log
   ```

### Fix permissions:
- 
   ```bash
   sudo chmod 644 /etc/apache2/apache2.conf
   sudo chmod 644 /var/log/apache2/error.log
   ```

### Restart services:
- 
   ```bash
   sudo service apache2 start
   ```

### Fix DNS:
- **Log in as support**.
- Flush the `iptables` rules:
   ```bash
   echo "nameserver 8.8.8.8" | sudo tee /etc/resolv.conf > /dev/null
   ```

### Free disk space
- 
   ```bash
   sudo rm /tmp/bigfile
   ```

### Flush firewall rules:
- 
   ```bash
   sudo iptables -F
   ```
   
### Verify all fixes:
- 
   ```bash
   curl http://localhost
    ping -c 4 google.com
    df -h
   ```

---

## Conclusion:
Congratulations. You have successfully completed the Broke Box troubleshooting exercise.
