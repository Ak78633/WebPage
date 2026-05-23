#!/bin/bash
# Start Nordblock web page with localtunnel (public URL)

set -e

DIR="/home/aki/WebPage"
PORT=8080
PID_FILE="$DIR/.lt-pids"
URL_FILE="$DIR/.lt-url"

# Source nvm
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && . "$NVM_DIR/nvm.sh"

# Kill any existing server and tunnel
pkill -f "http.server $PORT" 2>/dev/null || true
if [ -f "$PID_FILE" ]; then
  while read -r pid; do
    kill "$pid" 2>/dev/null || true
  done < "$PID_FILE"
  rm -f "$PID_FILE"
fi
rm -f "$URL_FILE"

# Start web server
nohup python3 -m http.server $PORT --directory $DIR > /tmp/nordblock-server.log 2>&1 &
SERVER_PID=$!
echo "Server started on http://localhost:$PORT (PID: $SERVER_PID)"

# Give server a moment to bind
sleep 1

# Start localtunnel and capture URL
lt --port $PORT --subdomain nordblock-ai-webpage > /tmp/nordblock-lt.log 2>&1 &
LT_PID=$!
echo "Tunnel starting (PID: $LT_PID)..."

# Save PIDs
echo "$SERVER_PID" > "$PID_FILE"
echo "$LT_PID" >> "$PID_FILE"

# Wait for lt to print the URL
for i in $(seq 1 30); do
  if grep -qP 'https://[a-z0-9-]+\.loca\.lt' /tmp/nordblock-lt.log 2>/dev/null; then
    break
  fi
  sleep 0.5
done

# Extract URL
URL=$(grep -oP 'https://[a-z0-9-]+\.loca\.lt' /tmp/nordblock-lt.log 2>/dev/null | head -1)

if [ -n "$URL" ]; then
  echo "$URL" > "$URL_FILE"
  echo ""
  echo "========================================="
  echo "  YOUR PUBLIC URL:"
  echo "  $URL"
  echo "========================================="
else
  echo ""
  echo "Tunnel URL not captured yet. Check: cat /tmp/nordblock-lt.log"
  echo "It should appear in a few seconds."
fi

echo ""
echo "PIDs saved to: $PID_FILE"
echo "Logs: /tmp/nordblock-server.log, /tmp/nordblock-lt.log"
echo "Stop with: bash $DIR/stop_localtunnel.sh"
