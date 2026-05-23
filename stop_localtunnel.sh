#!/bin/bash
# Stop Nordblock web server and localtunnel

DIR="/home/aki/WebPage"
PORT=8080
PID_FILE="$DIR/.lt-pids"
URL_FILE="$DIR/.lt-url"

# Kill tunnel + server PIDs if we have them
if [ -f "$PID_FILE" ]; then
  while read -r pid; do
    if kill -0 "$pid" 2>/dev/null; then
      echo "Killing PID $pid..."
      kill "$pid" 2>/dev/null || true
    fi
  done < "$PID_FILE"
  rm -f "$PID_FILE"
fi

# Also kill by process name as fallback
pkill -f "http.server $PORT" 2>/dev/null || true
pkill -f "lt --port $PORT" 2>/dev/null || true

# Clean up URL file
rm -f "$URL_FILE"

# Verify nothing's left
if pgrep -f "http.server $PORT" > /dev/null 2>&1 || pgrep -f "lt --port $PORT" > /dev/null 2>&1; then
  echo "Some processes may still be running. Try: pkill -f 'http.server 8080' && pkill -f 'lt --port 8080'"
else
  echo "Server and tunnel stopped."
fi
