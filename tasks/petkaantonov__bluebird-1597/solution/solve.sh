#!/bin/bash

set -euo pipefail
cd /app/bluebird

patch -p1 < /solution/fix.patch
