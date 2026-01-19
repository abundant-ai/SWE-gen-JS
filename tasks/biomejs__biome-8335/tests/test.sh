#!/bin/bash

cd /app/src

export RUST_BACKTRACE=1

# Copy HEAD test files from /tests (overwrites BASE state)
mkdir -p "crates/biome_js_analyze/tests/specs/nursery/useDestructuring"
cp "/tests/crates/biome_js_analyze/tests/specs/nursery/useDestructuring/invalid.js" "crates/biome_js_analyze/tests/specs/nursery/useDestructuring/invalid.js"
mkdir -p "crates/biome_js_analyze/tests/specs/nursery/useDestructuring"
cp "/tests/crates/biome_js_analyze/tests/specs/nursery/useDestructuring/invalid.js.snap" "crates/biome_js_analyze/tests/specs/nursery/useDestructuring/invalid.js.snap"
mkdir -p "crates/biome_js_analyze/tests/specs/nursery/useDestructuring"
cp "/tests/crates/biome_js_analyze/tests/specs/nursery/useDestructuring/valid.js" "crates/biome_js_analyze/tests/specs/nursery/useDestructuring/valid.js"
mkdir -p "crates/biome_js_analyze/tests/specs/nursery/useDestructuring"
cp "/tests/crates/biome_js_analyze/tests/specs/nursery/useDestructuring/valid.js.snap" "crates/biome_js_analyze/tests/specs/nursery/useDestructuring/valid.js.snap"

# Run the specific test for useDestructuring
# The test is in crates/biome_js_analyze/tests/specs/nursery/useDestructuring/
cargo test -p biome_js_analyze use_destructuring -- --nocapture
test_status=$?

if [ $test_status -eq 0 ]; then
  echo 1 > /logs/verifier/reward.txt
else
  echo 0 > /logs/verifier/reward.txt
fi
exit "$test_status"
