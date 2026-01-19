#!/bin/bash

set -euo pipefail
cd /app/src

patch -p1 < /solution/fix.patch

# Reinstall dependencies after patch (patch modifies package.json and yarn.lock)
yarn install --immutable

# Rebuild after patching
yarn build
