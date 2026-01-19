#!/bin/bash

cd /app/src

export RUST_BACKTRACE=1

# Copy HEAD test files from /tests (overwrites BASE state)
mkdir -p "crates/biome_js_analyze/tests/specs/nursery/noProto"
cp "/tests/crates/biome_js_analyze/tests/specs/nursery/noProto/invalid.js.snap" "crates/biome_js_analyze/tests/specs/nursery/noProto/invalid.js.snap"
mkdir -p "crates/biome_js_analyze/tests/specs/nursery/noProto"
cp "/tests/crates/biome_js_analyze/tests/specs/nursery/noProto/valid.js" "crates/biome_js_analyze/tests/specs/nursery/noProto/valid.js"
mkdir -p "crates/biome_js_analyze/tests/specs/nursery/noProto"
cp "/tests/crates/biome_js_analyze/tests/specs/nursery/noProto/valid.js.snap" "crates/biome_js_analyze/tests/specs/nursery/noProto/valid.js.snap"

# Run the specific JS analyzer tests affected by this PR
# The test files are in nursery/noProto/
# Running all nursery tests (narrow enough to be fast, broad enough to catch the test)
cargo test -p biome_js_analyze --test spec_tests nursery -- --nocapture
test_status=$?

if [ $test_status -eq 0 ]; then
  echo 1 > /logs/verifier/reward.txt
else
  echo 0 > /logs/verifier/reward.txt
fi
exit "$test_status"
