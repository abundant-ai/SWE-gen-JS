#!/bin/bash

set -euo pipefail
cd /app/src

patch -p1 < /solution/fix.patch

# Rebuild after applying fix (TypeScript + Langium grammar changes need rebuild)
pnpm run build
