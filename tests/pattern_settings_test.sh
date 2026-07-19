#!/usr/bin/env bash
set -euo pipefail

root="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"

! grep -Eq 'patLineWidth' "$root/src/ofApp.h" "$root/src/ofApp.cpp"
grep -Eq 'path\.setFillColor\(ofColor::black\)' "$root/src/ofApp.cpp"
grep -Eq 'path\.setStrokeWidth\(0\)' "$root/src/ofApp.cpp"
grep -Eq 'patAngle[[:space:]]*=[[:space:]]*30\.0f' "$root/src/ofApp.h"
grep -Eq 'ofSetCircleResolution\(160\)' "$root/src/ofApp.cpp"
grep -Eq 'ofEnableSmoothing\(\)' "$root/src/ofApp.cpp"
grep -Eq 'ofEnableAntiAliasing\(\)' "$root/src/ofApp.cpp"
grep -Eq 'ofGLFWWindowSettings[[:space:]]+settings' "$root/src/main.cpp"
grep -Eq 'settings\.numSamples[[:space:]]*=[[:space:]]*8' "$root/src/main.cpp"
grep -Eq 'ofPath[[:space:]]+patPath' "$root/src/ofApp.h"
grep -Eq 'configurarPatron\(\)' "$root/src/ofApp.cpp"
grep -Eq 'parsearPathSVGOriginal' "$root/src/ofApp.cpp"
grep -Eq 'patPath\.draw\(\)' "$root/src/ofApp.cpp"
! grep -Eq 'ofDraw(Line|Circle)\(' "$root/src/ofApp.cpp"
