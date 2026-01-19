#!/bin/bash

set -euo pipefail
cd /app/src

patch -p1 < /solution/fix.patch

# Reinstall dependencies after patch (patch updates package.json and yarn.lock)
yarn install --immutable

# Rebuild after installing new dependencies
yarn build
