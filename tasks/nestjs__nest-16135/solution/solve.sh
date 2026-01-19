#!/bin/bash

set -euo pipefail
cd /app/src

patch -p1 < /solution/fix.patch

# Install new dependencies added by the fix
npm ci --legacy-peer-deps

# Rebuild TypeScript after patching
npm run build
