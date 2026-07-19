#!/usr/bin/env bash
set -euo pipefail

root="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"

test "$(basename "$root")" = "prueba_camara"
grep -Eq '^ofxOpenCv$' "$root/addons.make"
test -f "$root/bin/data/haarcascade_frontalface_default.xml"
test -f "$root/prueba_camara.code-workspace"
! test -f "$root/template_of.code-workspace"
