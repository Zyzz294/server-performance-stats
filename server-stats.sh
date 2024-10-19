#!/bin/bash

echo "====== Server Performance Stats ======"

# Total CPU Usage
echo "1. Total CPU Usage:"
mpstat | awk '$12 ~ /[0-9.]+/ { print 100 - $12"%"}'

# Total Memory Usage (Free vs Used)
echo "2. Total Memory Usage (Free vs Used):"
free -m | awk 'NR==2{printf "Used: %sMB (%.2f%%), Free: %sMB (%.2f%%)\n", $3, $3*100/$2, $4, $4*100/$2}'

# Total Disk Usage (Free vs Used)
echo "3. Total Disk Usage (Free vs Used):"
df -h --total | awk '$1 == "total" {printf "Used: %s (%s), Available: %s\n", $3, $5, $4}'

# Top 5 processes by CPU usage
echo "4. Top 5 Processes by CPU Usage:"
ps -eo pid,ppid,cmd,%cpu --sort=-%cpu | head -n 6

# Top 5 processes by memory usage
echo "5. Top 5 Processes by Memory Usage:"
ps -eo pid,ppid,cmd,%mem --sort=-%mem | head -n 6

# Stretch Goal: OS version
echo "6. OS Version:"
uname -a

# Stretch Goal: Uptime
echo "7. Uptime:"
uptime -p

# Stretch Goal: Load Average
echo "8. Load Average:"
uptime | awk -F'load average:' '{print $2}'

# Stretch Goal: Logged in users
echo "9. Logged in Users:"
w

# Stretch Goal: Failed Login Attempts (requires root privileges)
echo "10. Failed Login Attempts:"
lastb | head -n 5

echo "====== End of Stats ======"

