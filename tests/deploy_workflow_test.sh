#!/usr/bin/env bash
set -euo pipefail

root="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
workflow="$root/.github/workflows/deploy.yml"

grep -Eq 'of-0\.12\.1-emscripten-emsdk-4\.0\.4-v3-nosourcemap' "$workflow"
grep -Eq 'PLATFORM_PTHREAD = ' "$workflow"
grep -Eq 'CFLAG_PLATFORM_PTHREAD = ' "$workflow"
grep -Eq -- '-gsource-map' "$workflow"
grep -Eq -- '-sLOAD_SOURCE_MAP=1' "$workflow"
grep -Eq 'find bin/em -type f' "$workflow"
grep -Eq 'actions/download-artifact@v4' "$workflow"
grep -Eq 'Install butler' "$workflow"
grep -Eq 'BUTLER_API_KEY: \$\{\{ secrets\.BUTLER_API_KEY \}\}' "$workflow"
grep -Eq './butler push _site aparinelli/prueba-camara:html5' "$workflow"
grep -Eq 'Patch oF random engine for Emscripten' "$workflow"
grep -Eq 'ofRandomEngine\.h' "$workflow"
grep -Eq 'TARGET_EMSCRIPTEN' "$workflow"
grep -Eq 'std::chrono::steady_clock::now\(\)' "$workflow"
