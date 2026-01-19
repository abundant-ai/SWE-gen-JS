#!/bin/bash

cd /app/src

export RUST_BACKTRACE=1

# Copy HEAD test files from /tests (overwrites BASE state)
mkdir -p "crates/biome_js_analyze/tests/specs/correctness/noConstantMathMinMaxClamp"
cp "/tests/crates/biome_js_analyze/tests/specs/correctness/noConstantMathMinMaxClamp/invalid.js" "crates/biome_js_analyze/tests/specs/correctness/noConstantMathMinMaxClamp/invalid.js"
mkdir -p "crates/biome_js_analyze/tests/specs/correctness/noConstantMathMinMaxClamp"
cp "/tests/crates/biome_js_analyze/tests/specs/correctness/noConstantMathMinMaxClamp/invalid.js.snap" "crates/biome_js_analyze/tests/specs/correctness/noConstantMathMinMaxClamp/invalid.js.snap"
mkdir -p "crates/biome_js_analyze/tests/specs/correctness/noPrecisionLoss"
cp "/tests/crates/biome_js_analyze/tests/specs/correctness/noPrecisionLoss/invalid.js" "crates/biome_js_analyze/tests/specs/correctness/noPrecisionLoss/invalid.js"
mkdir -p "crates/biome_js_analyze/tests/specs/correctness/noPrecisionLoss"
cp "/tests/crates/biome_js_analyze/tests/specs/correctness/noPrecisionLoss/invalid.js.snap" "crates/biome_js_analyze/tests/specs/correctness/noPrecisionLoss/invalid.js.snap"
mkdir -p "crates/biome_js_analyze/tests/specs/correctness/noPrecisionLoss"
cp "/tests/crates/biome_js_analyze/tests/specs/correctness/noPrecisionLoss/valid.js" "crates/biome_js_analyze/tests/specs/correctness/noPrecisionLoss/valid.js"
mkdir -p "crates/biome_js_analyze/tests/specs/correctness/noPrecisionLoss"
cp "/tests/crates/biome_js_analyze/tests/specs/correctness/noPrecisionLoss/valid.js.snap" "crates/biome_js_analyze/tests/specs/correctness/noPrecisionLoss/valid.js.snap"

# Build the tests after copying test files (tests are generated at compile time from file structure)
cargo test --no-run -p biome_js_analyze --test spec_tests

# Run the specific tests for noConstantMathMinMaxClamp and noPrecisionLoss
cargo test -p biome_js_analyze --test spec_tests -- specs::correctness::no_constant_math_min_max_clamp --nocapture
test_status_1=$?

cargo test -p biome_js_analyze --test spec_tests -- specs::correctness::no_precision_loss --nocapture
test_status_2=$?

# Both test suites must pass
if [ $test_status_1 -eq 0 ] && [ $test_status_2 -eq 0 ]; then
  test_status=0
else
  test_status=1
fi

if [ $test_status -eq 0 ]; then
  echo 1 > /logs/verifier/reward.txt
else
  echo 0 > /logs/verifier/reward.txt
fi
exit "$test_status"
