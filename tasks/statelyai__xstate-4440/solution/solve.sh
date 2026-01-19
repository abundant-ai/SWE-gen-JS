#!/bin/bash

set -euo pipefail
cd /app/src

patch -p1 < /solution/fix.patch

# Rerun preconstruct dev to update symlinks after patching
npx preconstruct dev
