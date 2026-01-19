#!/bin/bash

cd /app/src

export RUST_BACKTRACE=1

# Copy HEAD test files from /tests (overwrites BASE state)
mkdir -p "crates/biome_js_analyze/tests/specs/nursery/noEqualsToNull"
cp "/tests/crates/biome_js_analyze/tests/specs/nursery/noEqualsToNull/invalid.js" "crates/biome_js_analyze/tests/specs/nursery/noEqualsToNull/invalid.js"
mkdir -p "crates/biome_js_analyze/tests/specs/nursery/noEqualsToNull"
cp "/tests/crates/biome_js_analyze/tests/specs/nursery/noEqualsToNull/invalid.js.snap" "crates/biome_js_analyze/tests/specs/nursery/noEqualsToNull/invalid.js.snap"
mkdir -p "crates/biome_js_analyze/tests/specs/nursery/noEqualsToNull"
cp "/tests/crates/biome_js_analyze/tests/specs/nursery/noEqualsToNull/valid.js" "crates/biome_js_analyze/tests/specs/nursery/noEqualsToNull/valid.js"
mkdir -p "crates/biome_js_analyze/tests/specs/nursery/noEqualsToNull"
cp "/tests/crates/biome_js_analyze/tests/specs/nursery/noEqualsToNull/valid.js.snap" "crates/biome_js_analyze/tests/specs/nursery/noEqualsToNull/valid.js.snap"

# Run the specific tests for noEqualsToNull
# The tests are in crates/biome_js_analyze/tests/specs/nursery/noEqualsToNull/
cargo test -p biome_js_analyze no_equals_to_null -- --nocapture
test_status=$?

if [ $test_status -eq 0 ]; then
  echo 1 > /logs/verifier/reward.txt
else
  echo 0 > /logs/verifier/reward.txt
fi
exit "$test_status"
