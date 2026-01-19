#!/bin/bash

set -euo pipefail
cd /app/src

patch -p1 < /solution/fix.patch

# Rebuild after applying fix (transpile with Babel)
npm run clean && npm run build:es && npm run build:cjs
