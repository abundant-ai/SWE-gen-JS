#!/bin/bash

cd /app/src

export RUST_BACKTRACE=1

# Copy HEAD test files from /tests (overwrites BASE state)
mkdir -p "crates/biome_html_analyze/tests/specs/a11y/useValidAriaRole"
cp "/tests/crates/biome_html_analyze/tests/specs/a11y/useValidAriaRole/allowInvalidRoles.html" "crates/biome_html_analyze/tests/specs/a11y/useValidAriaRole/allowInvalidRoles.html"
mkdir -p "crates/biome_html_analyze/tests/specs/a11y/useValidAriaRole"
cp "/tests/crates/biome_html_analyze/tests/specs/a11y/useValidAriaRole/allowInvalidRoles.html.snap" "crates/biome_html_analyze/tests/specs/a11y/useValidAriaRole/allowInvalidRoles.html.snap"
mkdir -p "crates/biome_html_analyze/tests/specs/a11y/useValidAriaRole"
cp "/tests/crates/biome_html_analyze/tests/specs/a11y/useValidAriaRole/allowInvalidRoles.options.json" "crates/biome_html_analyze/tests/specs/a11y/useValidAriaRole/allowInvalidRoles.options.json"
mkdir -p "crates/biome_html_analyze/tests/specs/a11y/useValidAriaRole"
cp "/tests/crates/biome_html_analyze/tests/specs/a11y/useValidAriaRole/invalid.html" "crates/biome_html_analyze/tests/specs/a11y/useValidAriaRole/invalid.html"
mkdir -p "crates/biome_html_analyze/tests/specs/a11y/useValidAriaRole"
cp "/tests/crates/biome_html_analyze/tests/specs/a11y/useValidAriaRole/invalid.html.snap" "crates/biome_html_analyze/tests/specs/a11y/useValidAriaRole/invalid.html.snap"
mkdir -p "crates/biome_html_analyze/tests/specs/a11y/useValidAriaRole"
cp "/tests/crates/biome_html_analyze/tests/specs/a11y/useValidAriaRole/valid.html" "crates/biome_html_analyze/tests/specs/a11y/useValidAriaRole/valid.html"
mkdir -p "crates/biome_html_analyze/tests/specs/a11y/useValidAriaRole"
cp "/tests/crates/biome_html_analyze/tests/specs/a11y/useValidAriaRole/valid.html.snap" "crates/biome_html_analyze/tests/specs/a11y/useValidAriaRole/valid.html.snap"

# Run the specific test for useValidAriaRole
# The test is in crates/biome_html_analyze/tests/specs/a11y/useValidAriaRole/
cargo test -p biome_html_analyze use_valid_aria_role -- --nocapture
test_status=$?

if [ $test_status -eq 0 ]; then
  echo 1 > /logs/verifier/reward.txt
else
  echo 0 > /logs/verifier/reward.txt
fi
exit "$test_status"
