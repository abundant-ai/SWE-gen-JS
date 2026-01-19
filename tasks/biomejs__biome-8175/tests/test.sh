#!/bin/bash

cd /app/src

export RUST_BACKTRACE=1

# Copy HEAD test files from /tests (overwrites BASE state)
mkdir -p "crates/biome_css_formatter/tests/specs/css"
cp "/tests/crates/biome_css_formatter/tests/specs/css/units.css" "crates/biome_css_formatter/tests/specs/css/units.css"
mkdir -p "crates/biome_css_formatter/tests/specs/css"
cp "/tests/crates/biome_css_formatter/tests/specs/css/units.css.snap" "crates/biome_css_formatter/tests/specs/css/units.css.snap"

# Build the tests after copying test files (tests are generated at compile time from file structure)
cargo test --no-run -p biome_css_formatter --test spec_tests

# Run the specific tests for CSS units
# Test name pattern: formatter::css_module::css::units
cargo test -p biome_css_formatter --test spec_tests -- formatter::css_module::css::units --nocapture
test_status=$?

if [ $test_status -eq 0 ]; then
  echo 1 > /logs/verifier/reward.txt
else
  echo 0 > /logs/verifier/reward.txt
fi
exit "$test_status"
