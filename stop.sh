#!/bin/bash
# Stop Nordblock web server

PORT=8080
pkill -f "http.server $PORT" 2>/dev/null

if pgrep -f "http.server $PORT" > /dev/null; then
  echo "Server could not be stopped."
else
  echo "Server stopped."
fi
