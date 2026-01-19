#!/bin/bash

set -euo pipefail
cd /app/src

patch -p1 < /solution/fix.patch

# Rebuild TypeScript after applying the fix
yarn build:types && yarn build:cjs
