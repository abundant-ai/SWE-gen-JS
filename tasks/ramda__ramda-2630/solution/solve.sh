#!/bin/bash

set -euo pipefail
cd /app/src

patch -p1 < /solution/fix.patch

# Rebuild after applying fix to transpile new source files
npm run clean && npm run build:es && npm run build:cjs
