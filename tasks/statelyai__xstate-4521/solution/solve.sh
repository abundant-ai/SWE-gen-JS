#!/bin/bash

set -euo pipefail
cd /app/src

patch -p1 < /solution/fix.patch

# Refresh preconstruct dev builds to pick up source changes
yarn preconstruct dev
