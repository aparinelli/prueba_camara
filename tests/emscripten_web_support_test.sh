#!/usr/bin/env bash
set -euo pipefail

root="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
main_file="$root/src/main.cpp"
header_file="$root/src/ofApp.h"
app_file="$root/src/ofApp.cpp"
addons_file="$root/addons.make"
config_file="$root/config.make"

assert_not_contains() {
  local pattern="$1"
  shift
  if grep -Eq -- "$pattern" "$@"; then
    echo "Unexpected pattern found: $pattern" >&2
    exit 1
  fi
}

grep -q '#ifdef TARGET_EMSCRIPTEN' "$main_file"
grep -Eq 'ofSetLogLevel\(OF_LOG_SILENT\)' "$main_file"
grep -Eq 'ofGLWindowSettings[[:space:]]+settings;' "$main_file"
grep -Eq 'settings\.setSize\(1920,[[:space:]]*1080\)' "$main_file"
grep -Fq 'auto window = ofCreateWindow(settings);' "$main_file"
grep -Fq 'ofRunApp(window, std::make_shared<ofApp>());' "$main_file"
grep -Fq 'ofRunMainLoop();' "$main_file"
assert_not_contains 'ofSetupOpenGL\(1920,[[:space:]]*1080,[[:space:]]*OF_WINDOW\)' "$main_file"
assert_not_contains 'ofRunApp\(new ofApp\(\)\)' "$main_file"
perl -0ne 'exit 0 if /ifneq \(\$\(findstring emcc,\$\(CC\)\),\)\s+PROJECT_CFLAGS[[:space:]]*=.*-fexceptions\s+PROJECT_LDFLAGS[[:space:]]*=.*-fexceptions.*-sASSERTIONS=1.*-sGL_ASSERTIONS=1.*-sMIN_WEBGL_VERSION=2.*-sMAX_WEBGL_VERSION=2\s+endif/s; exit 1' "$config_file"
grep -Eq '^ofxSvg$' "$addons_file"
grep -Eq '#include "ofxSvg\.h"' "$header_file"
grep -Eq 'ofxSvg svg;' "$app_file"
grep -Eq 'svg\.loadFromString' "$app_file"
assert_not_contains 'tokenizarPathSVG|leerNumeroPath|esTokenComando|esComandoPath' "$app_file"
grep -Eq '#ifndef TARGET_EMSCRIPTEN' "$header_file"
grep -Eq '#include "ofxCvHaarFinder\.h"' "$header_file"
grep -Eq 'ofxCvHaarFinder[[:space:]]+path144FaceFinder' "$header_file"
grep -Eq '#ifndef TARGET_EMSCRIPTEN' "$app_file"
perl -0ne 'exit 0 if /#ifndef TARGET_EMSCRIPTEN\s+ofRectangle elegirCaraPrincipal\(const std::vector<ofxCvBlob>& blobs\)[\s\S]*?#endif/s; exit 1' "$app_file"
perl -0ne 'exit 0 if /configurarDetectorRostroPath144\(\);\s+#ifndef TARGET_EMSCRIPTEN\s+configurarPath144CamaraShaders\(\);\s+#endif\s+actualizarMascaraPath144\(\);/s; exit 1' "$app_file"
perl -0ne 'exit 0 if /#ifdef TARGET_EMSCRIPTEN\s+path144CameraReady = false;\s+#else\s+seleccionarDispositivoCamaraPath144\(\);\s+configurarRecursosCamaraPath144\(\);\s+#endif/s; exit 1' "$app_file"
perl -0ne 'exit 0 if /#ifdef TARGET_EMSCRIPTEN[\s\S]*?attribute vec4 position;[\s\S]*?varying vec2 vPosition;[\s\S]*?gl_FragColor = vec4\(1\.0, 0\.0, 0\.0, alpha\);[\s\S]*?#else[\s\S]*?#version 150[\s\S]*?#endif/s; exit 1' "$app_file"
grep -Eq 'path144FaceFinder\.findHaarObjects' "$app_file"
grep -Eq 'no face detection in Emscripten' "$app_file"
