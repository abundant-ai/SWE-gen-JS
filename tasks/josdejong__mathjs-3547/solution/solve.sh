#!/bin/bash

set -euo pipefail
cd /app/src

# Apply fix patch (force forward application, no backup)
patch -p1 --forward --no-backup-if-mismatch < /solution/fix.patch || true

# Rebuild after applying fix to update built artifacts
npm run build
