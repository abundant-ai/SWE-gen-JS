#!/bin/bash

set -euo pipefail
cd /app/src

# Apply the fix patch (some hunks may fail for generated files, that's OK)
patch -p1 < /solution/fix.patch || true

# Rebuild the native module to regenerate index.d.ts and apply Rust changes
cd packages/turbo-repository
pnpm run build
