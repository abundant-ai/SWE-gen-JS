#!/bin/bash

set -euo pipefail
cd /app/src

patch -p1 < /solution/fix.patch

# Touch the files that changed to force minimal rebuild
# This avoids a full rebuild while still recompiling changed code
touch crates/turborepo-lib/src/cli/mod.rs
touch crates/turborepo-lib/src/config.rs
touch crates/turborepo-lib/src/lib.rs
touch crates/turborepo/src/main.rs

# Rebuild with minimal debug info and single-threaded linking to reduce memory
CARGO_PROFILE_DEV_DEBUG=0 cargo build -p turbo -j1
