#!/bin/bash

set -euo pipefail
cd /app/src

patch -p1 < /solution/fix.patch

# Reinstall dependencies (patch upgrades yaml-unist-parser which adds allowDuplicateKeysInMap support)
yarn install --immutable

# Rebuild after dependency upgrade
yarn build
