#!/bin/bash

set -euo pipefail
cd /app/src

patch -p1 < /solution/fix.patch

# Reinstall dependencies to upgrade espree from 9.1.0 to 9.2.0
rm -rf node_modules
PUPPETEER_SKIP_DOWNLOAD=true npm install --legacy-peer-deps
