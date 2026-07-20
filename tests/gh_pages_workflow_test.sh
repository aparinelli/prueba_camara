#!/usr/bin/env bash
set -euo pipefail

root="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
workflow="$root/.github/workflows/deploy.yml"

assert_not_contains() {
  local pattern="$1"
  shift
  if grep -Eq -- "$pattern" "$@"; then
    echo "Unexpected pattern found: $pattern" >&2
    exit 1
  fi
}

grep -Eq '^name: Build and Deploy to GitHub Pages$' "$workflow"
if command -v ruby >/dev/null; then
  ruby -e 'require "yaml"; YAML.load_file(ARGV[0])' "$workflow"
fi
grep -Eq 'actions/configure-pages@v5' "$workflow"
grep -Eq 'actions/upload-pages-artifact@v3' "$workflow"
grep -Eq 'actions/deploy-pages@v4' "$workflow"
grep -Eq 'find bin/em -type f' "$workflow"
grep -Eq 'PLATFORM_PTHREAD = ' "$workflow"
grep -Eq 'CFLAG_PLATFORM_PTHREAD = ' "$workflow"
grep -Eq -- '-fexceptions' "$workflow"
grep -Eq -- '-s MIN_WEBGL_VERSION=2' "$workflow"
grep -Eq -- '-s MAX_WEBGL_VERSION=2' "$workflow"
grep -Eq -- '-gsource-map' "$workflow"
grep -Eq -- '-sLOAD_SOURCE_MAP=1' "$workflow"
grep -Eq 'Patch oF Emscripten WebGL context setup' "$workflow"
grep -Eq 'failed to create a WebGL2 context' "$workflow"
grep -Eq 'emscripten_webgl_make_context_current' "$workflow"
grep -Eq 'EMSCRIPTEN_RESULT_SUCCESS' "$workflow"
assert_not_contains 'rendererMajor = 1|attrs\.antialias = 0|attrs\.stencil = 0' "$workflow"
assert_not_contains 'emscript en|emscrip ten' "$workflow"
grep -Eq 'Patch oF random engine for Emscripten' "$workflow"
grep -Eq 'Normalize generated Emscripten HTML bootstrap' "$workflow"
grep -Eq 'Module.canvas = Module.canvas \|\| document.getElementById\("canvas"\)' "$workflow"
grep -Eq 'script type="text/javascript" src="app\.js"' "$workflow"
grep -Eq 'script type="text/javascript" src="index\.js"' "$workflow"
grep -Eq 'Patch generated Emscripten target lookup' "$workflow"
grep -Eq 'findCanvasEventTarget=target=>Module\["canvas"\]' "$workflow"
grep -Eq '#canvas' "$workflow"
assert_not_contains 'target === ""' "$workflow"
assert_not_contains 'butler|itch\.io|BUTLER_API_KEY' "$workflow"
