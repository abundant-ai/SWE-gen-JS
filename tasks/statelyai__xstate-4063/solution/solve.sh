#!/bin/bash

set -euo pipefail
cd /app/src

patch -p1 < /solution/fix.patch

# Re-run preconstruct dev to update the dev build with patched files
npx preconstruct dev
