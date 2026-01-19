#!/bin/bash

cd /app/src

export RUST_BACKTRACE=1

# Copy HEAD test files from /tests (overwrites BASE state)
mkdir -p "crates/biome_html_analyze/tests/specs/a11y/noAutofocus"
cp "/tests/crates/biome_html_analyze/tests/specs/a11y/noAutofocus/invalid.html" "crates/biome_html_analyze/tests/specs/a11y/noAutofocus/invalid.html"
mkdir -p "crates/biome_html_analyze/tests/specs/a11y/noAutofocus"
cp "/tests/crates/biome_html_analyze/tests/specs/a11y/noAutofocus/invalid.html.snap" "crates/biome_html_analyze/tests/specs/a11y/noAutofocus/invalid.html.snap"
mkdir -p "crates/biome_html_analyze/tests/specs/a11y/noAutofocus"
cp "/tests/crates/biome_html_analyze/tests/specs/a11y/noAutofocus/valid.html" "crates/biome_html_analyze/tests/specs/a11y/noAutofocus/valid.html"
mkdir -p "crates/biome_html_analyze/tests/specs/a11y/noAutofocus"
cp "/tests/crates/biome_html_analyze/tests/specs/a11y/noAutofocus/valid.html.snap" "crates/biome_html_analyze/tests/specs/a11y/noAutofocus/valid.html.snap"

# Run the snapshot tests for the biome_html_analyze package
# These tests verify the noAutofocus rule for HTML files
cargo test -p biome_html_analyze -- --nocapture
test_status=$?

if [ $test_status -eq 0 ]; then
  echo 1 > /logs/verifier/reward.txt
else
  echo 0 > /logs/verifier/reward.txt
fi
exit "$test_status"
