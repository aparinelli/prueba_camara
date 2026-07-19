#!/usr/bin/env bash
set -euo pipefail

root="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"

for id in path139 path140 path141 path142; do
  grep -Eq "\"$id\"" "$root/src/ofApp.cpp"
done

grep -Eq '"path140"[[:space:]]*,' "$root/src/ofApp.cpp"
grep -Eq '1463\.625,150\.98283' "$root/src/ofApp.cpp"
grep -Eq '1632\.1568f,[[:space:]]*180\.71332f' "$root/src/ofApp.cpp"
