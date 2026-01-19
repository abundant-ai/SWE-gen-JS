#!/bin/bash

set -euo pipefail
cd /app/src

# Apply text changes from fix.patch
patch -p1 < /solution/fix.patch

# Manually copy binary file that patch can't handle
mkdir -p .yarn/cache
cp /solution/@verdaccio-scope-verdaccio-auth-foo-npm-0.0.2-e8d6fdf0d9-99f4727a67.zip .yarn/cache/
