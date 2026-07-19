#!/usr/bin/env bash
set -euo pipefail

ROOT_DIR="$(cd "$(dirname "$0")/.." && pwd)"
MAIN_FILE="$ROOT_DIR/src/main.cpp"

grep -q "#ifdef TARGET_EMSCRIPTEN" "$MAIN_FILE"
grep -Eq "ofSetupOpenGL\\(1920,[[:space:]]*1080,[[:space:]]*OF_WINDOW\\)" "$MAIN_FILE"
grep -Eq "ofRunApp\\(new ofApp\\(\\)\\)" "$MAIN_FILE"
grep -q "#else" "$MAIN_FILE"
grep -Eq "ofGLFWWindowSettings[[:space:]]+settings" "$MAIN_FILE"
grep -q "#endif" "$MAIN_FILE"
