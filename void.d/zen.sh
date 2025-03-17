#!/bin/bash

URL="https://github.com/zen-browser/desktop/releases/download/1.9.1b/zen-x86_64.appimage"

if mkdir -p "$HOME"/.local/bin; then
  if wget $URL -O zen; then
    chmod +x zen
    mv zen "$HOME"/.local/bin/
  fi
fi
