#!/usr/bin/env bash
set -e
gh repo edit Ak78633/WebPage --add-pages-source gh-pages
echo "GitHub Pages enabled. Your site will be live at: https://ak78633.github.io/WebPage/"
echo "It may take 30-60 seconds for the build to complete."
