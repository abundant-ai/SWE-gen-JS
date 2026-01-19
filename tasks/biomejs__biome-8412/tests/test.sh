#!/bin/bash

cd /app/src

export RUST_BACKTRACE=1

# Copy HEAD test files from /tests (overwrites BASE state)
mkdir -p "crates/biome_html_analyze/tests/specs/a11y/noSvgWithoutTitle"
cp "/tests/crates/biome_html_analyze/tests/specs/a11y/noSvgWithoutTitle/invalid.html" "crates/biome_html_analyze/tests/specs/a11y/noSvgWithoutTitle/invalid.html"
mkdir -p "crates/biome_html_analyze/tests/specs/a11y/noSvgWithoutTitle"
cp "/tests/crates/biome_html_analyze/tests/specs/a11y/noSvgWithoutTitle/invalid.html.snap" "crates/biome_html_analyze/tests/specs/a11y/noSvgWithoutTitle/invalid.html.snap"
mkdir -p "crates/biome_html_analyze/tests/specs/a11y/noSvgWithoutTitle"
cp "/tests/crates/biome_html_analyze/tests/specs/a11y/noSvgWithoutTitle/valid.html" "crates/biome_html_analyze/tests/specs/a11y/noSvgWithoutTitle/valid.html"
mkdir -p "crates/biome_html_analyze/tests/specs/a11y/noSvgWithoutTitle"
cp "/tests/crates/biome_html_analyze/tests/specs/a11y/noSvgWithoutTitle/valid.html.snap" "crates/biome_html_analyze/tests/specs/a11y/noSvgWithoutTitle/valid.html.snap"

# Run the specific HTML analyzer tests affected by this PR
# The test files are in a11y/noSvgWithoutTitle/
# Running all a11y tests (narrow enough to be fast, broad enough to catch the test)
cargo test -p biome_html_analyze --test spec_tests a11y -- --nocapture
test_status=$?

if [ $test_status -eq 0 ]; then
  echo 1 > /logs/verifier/reward.txt
else
  echo 0 > /logs/verifier/reward.txt
fi
exit "$test_status"
