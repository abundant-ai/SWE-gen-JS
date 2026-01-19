#!/bin/bash

set -euo pipefail
cd /app/src

patch -p1 < /solution/fix.patch

# Reinstall dependencies to get updated Flow version
yarn install --frozen-lockfile

# Rebuild to regenerate dist/ with fixed Flow types
yarn build
