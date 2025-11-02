#!/bin/bash
# ============================================
# Server Performance Stats - Beginner Level
# Author: Sidra Saman
# Description: Analyzes basic server performance stats
# ============================================

echo "============================================"
echo " SERVER PERFORMANCE STATS"
echo "============================================"
echo "Date & Time: $(date)"
echo "Hostname: $(hostname)"
echo "============================================"

# ---- CPU Usage ----
echo " CPU Usage:"
top -bn1 | grep "Cpu(s)" | awk '{print "User: " $2"% | System: " $4"% | Idle: " $8"%"}'
echo

# ---- Memory Usage ----
echo " Memory Usage:"
free -h | awk '/Mem:/ {
    total=$2; used=$3; free=$4;
    printf("Total: %s | Used: %s | Free: %s\n", total, used, free)
}'
echo

# ---- Disk Usage ----
echo " Disk Usage:"
df -h --total | grep total | awk '{print "Total: " $2 " | Used: " $3 " | Free: " $4 " | Used: " $5}'
echo

# ---- Top 5 Processes by CPU ----
echo " Top 5 Processes by CPU Usage:"
ps -eo pid,comm,%cpu --sort=-%cpu | head -n 6
echo

# ---- Top 5 Processes by Memory ----
echo " Top 5 Processes by Memory Usage:"
ps -eo pid,comm,%mem --sort=-%mem | head -n 6
echo

# ---- (Stretch Goals) ----
echo "============================================"
echo " ADDITIONAL SERVER INFO"
echo "============================================"

# OS Version
echo " OS Version:"
cat /etc/os-release | grep PRETTY_NAME | cut -d= -f2 | tr -d '"'
echo

# Uptime
echo " Uptime:"
uptime -p
echo

# Load Average
echo " Load Average:"
uptime | awk -F'load average:' '{ print $2 }'
echo

# Logged in Users
echo " Logged in Users:"
who | awk '{print $1}' | sort | uniq
echo

# Failed Login Attempts (requires root or sudo)
if [ "$(id -u)" -eq 0 ]; then
    echo " Failed Login Attempts:"
    lastb | head -n 10
else
    echo " Failed Login Attempts: (Run as root to view)"
fi

echo "============================================"
echo " Stats collection complete."
echo "============================================"
