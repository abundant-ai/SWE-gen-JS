#!/bin/bash

cd /app/src

export RUST_BACKTRACE=1

# Copy HEAD test files from /tests (overwrites BASE state)
mkdir -p "crates/biome_js_analyze/tests/specs/nursery/noFloatingPromises"
cp "/tests/crates/biome_js_analyze/tests/specs/nursery/noFloatingPromises/invalid.js" "crates/biome_js_analyze/tests/specs/nursery/noFloatingPromises/invalid.js"
mkdir -p "crates/biome_js_analyze/tests/specs/nursery/noFloatingPromises"
cp "/tests/crates/biome_js_analyze/tests/specs/nursery/noFloatingPromises/invalid.js.snap" "crates/biome_js_analyze/tests/specs/nursery/noFloatingPromises/invalid.js.snap"

# Build the tests after copying test files (tests are generated at compile time from file structure)
cargo test --no-run -p biome_js_analyze --test spec_tests

# Run the specific test for noFloatingPromises
cargo test -p biome_js_analyze --test spec_tests -- specs::nursery::no_floating_promises --nocapture
test_status=$?

if [ $test_status -eq 0 ]; then
  echo 1 > /logs/verifier/reward.txt
else
  echo 0 > /logs/verifier/reward.txt
fi
exit "$test_status"
