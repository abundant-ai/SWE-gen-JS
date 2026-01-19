#!/bin/bash

cd /app/src

export RUST_BACKTRACE=1

# Copy HEAD test files from /tests (overwrites BASE state)
mkdir -p "crates/biome_js_analyze/tests/specs/nursery/noFloatingPromises"
cp "/tests/crates/biome_js_analyze/tests/specs/nursery/noFloatingPromises/issue8292.ts" "crates/biome_js_analyze/tests/specs/nursery/noFloatingPromises/issue8292.ts"
mkdir -p "crates/biome_js_analyze/tests/specs/nursery/noFloatingPromises"
cp "/tests/crates/biome_js_analyze/tests/specs/nursery/noFloatingPromises/issue8292.ts.snap" "crates/biome_js_analyze/tests/specs/nursery/noFloatingPromises/issue8292.ts.snap"

# Run the specific test for issue8292 in noFloatingPromises
# The test is in crates/biome_js_analyze/tests/specs/nursery/noFloatingPromises/issue8292.ts
cargo test -p biome_js_analyze issue8292 -- --nocapture
test_status=$?

if [ $test_status -eq 0 ]; then
  echo 1 > /logs/verifier/reward.txt
else
  echo 0 > /logs/verifier/reward.txt
fi
exit "$test_status"
