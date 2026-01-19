#!/bin/bash

cd /app/src

export RUST_BACKTRACE=1

# Copy HEAD test files from /tests (overwrites BASE state)
mkdir -p "crates/biome_html_formatter/tests/specs/html/elements"
cp "/tests/crates/biome_html_formatter/tests/specs/html/elements/iframe-allow.html" "crates/biome_html_formatter/tests/specs/html/elements/iframe-allow.html"
mkdir -p "crates/biome_html_formatter/tests/specs/html/elements"
cp "/tests/crates/biome_html_formatter/tests/specs/html/elements/iframe-allow.html.snap" "crates/biome_html_formatter/tests/specs/html/elements/iframe-allow.html.snap"

# Run the specific test for HTML formatter iframe-allow
# The test is in crates/biome_html_formatter/tests/specs/html/elements/
cargo test -p biome_html_formatter iframe_allow -- --nocapture
test_status=$?

if [ $test_status -eq 0 ]; then
  echo 1 > /logs/verifier/reward.txt
else
  echo 0 > /logs/verifier/reward.txt
fi
exit "$test_status"
