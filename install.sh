#!/usr/bin/env bash
set -e

echo "Installing system dependencies..."
sudo apt-get install -y libgtk-3-0 libgbm1 libnss3 libxcomposite1 libxdamage1 libxrandr2 fonts-noto-color-emoji

echo "Installing agent-browser with dependencies..."
agent-browser install --with-deps

echo "Done!"
