#!/bin/bash

cd /app/src

export RUST_BACKTRACE=1

# Copy HEAD test files from /tests (overwrites BASE state)
mkdir -p "crates/biome_html_analyze/tests/specs/a11y/useButtonType"
cp "/tests/crates/biome_html_analyze/tests/specs/a11y/useButtonType/invalid.html" "crates/biome_html_analyze/tests/specs/a11y/useButtonType/invalid.html"
mkdir -p "crates/biome_html_analyze/tests/specs/a11y/useButtonType"
cp "/tests/crates/biome_html_analyze/tests/specs/a11y/useButtonType/invalid.html.snap" "crates/biome_html_analyze/tests/specs/a11y/useButtonType/invalid.html.snap"
mkdir -p "crates/biome_html_analyze/tests/specs/a11y/useButtonType"
cp "/tests/crates/biome_html_analyze/tests/specs/a11y/useButtonType/valid.html" "crates/biome_html_analyze/tests/specs/a11y/useButtonType/valid.html"
mkdir -p "crates/biome_html_analyze/tests/specs/a11y/useButtonType"
cp "/tests/crates/biome_html_analyze/tests/specs/a11y/useButtonType/valid.html.snap" "crates/biome_html_analyze/tests/specs/a11y/useButtonType/valid.html.snap"

# Run the specific tests for useButtonType
# The tests are in crates/biome_html_analyze/tests/specs/a11y/useButtonType/
cargo test -p biome_html_analyze use_button_type -- --nocapture
test_status=$?

if [ $test_status -eq 0 ]; then
  echo 1 > /logs/verifier/reward.txt
else
  echo 0 > /logs/verifier/reward.txt
fi
exit "$test_status"
