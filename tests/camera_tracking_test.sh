#!/usr/bin/env bash
set -euo pipefail

root="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"

test "$(basename "$root")" = "prueba_camara"
grep -Eq '^ofxOpenCv$' "$root/addons.make"
test -f "$root/bin/data/haarcascade_frontalface_default.xml"
test -f "$root/prueba_camara.code-workspace"
! test -f "$root/template_of.code-workspace"
grep -Eq '#include "ofxCvHaarFinder\.h"' "$root/src/ofApp.h"
grep -Eq 'ofxCvHaarFinder[[:space:]]+path144FaceFinder' "$root/src/ofApp.h"
grep -Eq 'ofRectangle[[:space:]]+path144Bounds' "$root/src/ofApp.h"
grep -Eq 'glm::vec2[[:space:]]+path144CameraFocus' "$root/src/ofApp.h"
grep -Eq 'actualizarTrackingRostroPath144\(\)' "$root/src/ofApp.h" "$root/src/ofApp.cpp"
grep -Eq 'path144FaceFinder\.findHaarObjects' "$root/src/ofApp.cpp"
