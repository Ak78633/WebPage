#!/usr/bin/env bash
set -e
TOKEN=$(gh auth token)
# Create the Pages site (POST)
curl -s -X POST "https://api.github.com/repos/Ak78633/WebPage/pages" \
  -H "Authorization: Bearer $TOKEN" \
  -H "Accept: application/vnd.github+json" \
  -H "X-GitHub-Api-Version: 2022-11-28" \
  -d '{"source":{"branch":"main","path":"/"}}'
echo ""
echo "Pages site creation triggered. Check status at:"
echo "https://github.com/Ak78633/WebPage/settings/pages"
