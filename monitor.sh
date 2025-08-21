#!/bin/bash
# Simple monitoring dashboard

while true; do
  clear
  echo "===== SERVER STATS ====="
  date
  echo
  echo "🖥️ CPU Usage:"
  mpstat 1 1 | awk '/Average/ && $12 ~ /[0-9.]+/ {print 100 - $12"%"}'
  echo
  echo "💾 Memory Usage:"
  free | awk '/^Mem:/ {used=$3; total=$2; free=$4; printf "Used: %dMi / %.1fGi (Free: %.1fGi), Usage: %d%%\n", used/1024, total/1024/1024, free/1024/1024, (used/total)*100 }'
  echo
  echo "📊 Storage Usage:"
  df -h / | awk 'NR==2 {print "Total: "$2", Used: "$3", Available: "$4", Usage: "$5}'
  echo
  echo "📊 Load Average (1m, 5m, 15m):"
  uptime | awk -F'load average: ' '{print $2}'
  echo
  echo "Press CTRL+C to quit."
  sleep 2
done
