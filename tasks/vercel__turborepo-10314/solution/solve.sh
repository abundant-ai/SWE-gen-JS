#!/bin/bash

set -euo pipefail
cd /app/src

patch -p1 < /solution/fix.patch

# Rebuild the Rust package after applying fix
cd packages/turbo-repository && pnpm run build
