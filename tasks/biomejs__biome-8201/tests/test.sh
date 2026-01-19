#!/bin/bash

cd /app/src

export RUST_BACKTRACE=1

# Copy HEAD test files from /tests (overwrites BASE state)
mkdir -p "crates/biome_js_analyze/tests/specs/nursery/noTernary"
cp "/tests/crates/biome_js_analyze/tests/specs/nursery/noTernary/invalid.js" "crates/biome_js_analyze/tests/specs/nursery/noTernary/invalid.js"
mkdir -p "crates/biome_js_analyze/tests/specs/nursery/noTernary"
cp "/tests/crates/biome_js_analyze/tests/specs/nursery/noTernary/invalid.js.snap" "crates/biome_js_analyze/tests/specs/nursery/noTernary/invalid.js.snap"
mkdir -p "crates/biome_js_analyze/tests/specs/nursery/noTernary"
cp "/tests/crates/biome_js_analyze/tests/specs/nursery/noTernary/valid.js" "crates/biome_js_analyze/tests/specs/nursery/noTernary/valid.js"
mkdir -p "crates/biome_js_analyze/tests/specs/nursery/noTernary"
cp "/tests/crates/biome_js_analyze/tests/specs/nursery/noTernary/valid.js.snap" "crates/biome_js_analyze/tests/specs/nursery/noTernary/valid.js.snap"

# Build the tests after copying test files (tests are generated at compile time from file structure)
cargo test --no-run -p biome_js_analyze --test spec_tests

# Run the specific tests for noTernary rule
# Test names: specs::nursery::no_ternary::invalid_js and specs::nursery::no_ternary::valid_js
cargo test -p biome_js_analyze --test spec_tests -- specs::nursery::no_ternary --nocapture
test_status=$?

if [ $test_status -eq 0 ]; then
  echo 1 > /logs/verifier/reward.txt
else
  echo 0 > /logs/verifier/reward.txt
fi
exit "$test_status"
