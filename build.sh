#!/usr/bin/env bash
# Keeps 404.html in sync with index.html.
# GitHub Pages serves 404.html for any path it doesn't recognize as a file
# (e.g. /decision-center/, /reports/, etc). Since 404.html is an identical
# copy of index.html, the app's own JS router (see ROUTE_MAP in index.html)
# reads the URL and renders the right screen — giving every page its own
# shareable, refreshable URL.
#
# Run this after every edit to index.html, then commit both files.
set -e
cp index.html 404.html
echo "404.html updated from index.html"
