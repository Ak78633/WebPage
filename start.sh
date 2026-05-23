#!/bin/bash
# Start Nordblock web server in the background

PORT=8080
DIR="/home/aki/WebPage"

# Kill any existing instance first
pkill -f "http.server $PORT" 2>/dev/null

nohup python3 -m http.server $PORT --directory $DIR > /tmp/nordblock-server.log 2>&1 &
echo "Server started on http://localhost:$PORT"
echo "PID: $!"
echo "Logs: /tmp/nordblock-server.log"
