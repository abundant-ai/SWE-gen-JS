#!/bin/bash

set -euo pipefail
cd /app/src

patch -p1 < /solution/fix.patch

# Rebuild TypeScript packages after applying fix
npx nx run-many --target=build --all
