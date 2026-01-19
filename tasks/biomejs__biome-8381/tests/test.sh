#!/bin/bash

cd /app/src

export RUST_BACKTRACE=1

# Copy HEAD test files from /tests (overwrites BASE state)
mkdir -p "crates/biome_html_analyze/tests/specs/a11y/useAriaPropsForRole"
cp "/tests/crates/biome_html_analyze/tests/specs/a11y/useAriaPropsForRole/invalid.html" "crates/biome_html_analyze/tests/specs/a11y/useAriaPropsForRole/invalid.html"
mkdir -p "crates/biome_html_analyze/tests/specs/a11y/useAriaPropsForRole"
cp "/tests/crates/biome_html_analyze/tests/specs/a11y/useAriaPropsForRole/invalid.html.snap" "crates/biome_html_analyze/tests/specs/a11y/useAriaPropsForRole/invalid.html.snap"
mkdir -p "crates/biome_html_analyze/tests/specs/a11y/useAriaPropsForRole"
cp "/tests/crates/biome_html_analyze/tests/specs/a11y/useAriaPropsForRole/valid.html" "crates/biome_html_analyze/tests/specs/a11y/useAriaPropsForRole/valid.html"
mkdir -p "crates/biome_html_analyze/tests/specs/a11y/useAriaPropsForRole"
cp "/tests/crates/biome_html_analyze/tests/specs/a11y/useAriaPropsForRole/valid.html.snap" "crates/biome_html_analyze/tests/specs/a11y/useAriaPropsForRole/valid.html.snap"
mkdir -p "crates/biome_js_analyze/tests/specs/a11y/useAriaPropsForRole"
cp "/tests/crates/biome_js_analyze/tests/specs/a11y/useAriaPropsForRole/invalid.jsx" "crates/biome_js_analyze/tests/specs/a11y/useAriaPropsForRole/invalid.jsx"
mkdir -p "crates/biome_js_analyze/tests/specs/a11y/useAriaPropsForRole"
cp "/tests/crates/biome_js_analyze/tests/specs/a11y/useAriaPropsForRole/invalid.jsx.snap" "crates/biome_js_analyze/tests/specs/a11y/useAriaPropsForRole/invalid.jsx.snap"

# Run the specific a11y tests for useAriaPropsForRole in both HTML and JS analyzers
# The test files are in a11y/useAriaPropsForRole directories
# Running spec_tests for the a11y category to include the useAriaPropsForRole test case
cargo test -p biome_html_analyze --test spec_tests a11y -- --nocapture
test_status_html=$?

cargo test -p biome_js_analyze --test spec_tests a11y -- --nocapture
test_status_js=$?

# Both tests need to pass
if [ $test_status_html -eq 0 ] && [ $test_status_js -eq 0 ]; then
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
