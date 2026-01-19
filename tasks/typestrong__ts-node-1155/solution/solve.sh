#!/bin/bash

set -euo pipefail
cd /app/src

# Apply the actual fix patch
# Note: actual-fix.patch contains the fix (OLD→NEW direction)
patch -p1 < /solution/actual-fix.patch

# Rebuild after applying the patch
npm run build
