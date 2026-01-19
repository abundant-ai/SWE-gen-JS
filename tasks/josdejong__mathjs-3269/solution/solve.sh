#!/bin/bash

set -euo pipefail
cd /app/src

patch -p1 < /solution/fix.patch

# Rebuild after patching to reflect fixed state in built artifacts
npm run build
