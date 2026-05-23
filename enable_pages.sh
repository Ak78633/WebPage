#!/usr/bin/env bash
set -e
TOKEN=$(gh auth token)
curl -s -X PUT "https://api.github.com/repos/Ak78633/WebPage/pages" \
  -H "Authorization: Bearer $TOKEN" \
  -H "Accept: application/vnd.github+json" \
  -H "X-GitHub-Api-Version: 2022-11-28" \
  -d '{"source":{"branch":"gh-pages","path":"/"}}'
echo ""
echo "GitHub Pages enabled. Your site will be live at: https://ak78633.github.io/WebPage/"
echo "It may take 30-60 seconds for the build to complete."
