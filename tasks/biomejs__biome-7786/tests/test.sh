#!/bin/bash

cd /app/src

export RUST_BACKTRACE=1

# Copy HEAD test files from /tests (overwrites BASE state)
mkdir -p "crates/biome_grit_patterns/tests/specs/ts"
cp "/tests/crates/biome_grit_patterns/tests/specs/ts/matchBacktickSnippet.grit" "crates/biome_grit_patterns/tests/specs/ts/matchBacktickSnippet.grit"
mkdir -p "crates/biome_grit_patterns/tests/specs/ts"
cp "/tests/crates/biome_grit_patterns/tests/specs/ts/matchBacktickSnippet.snap" "crates/biome_grit_patterns/tests/specs/ts/matchBacktickSnippet.snap"
mkdir -p "crates/biome_grit_patterns/tests/specs/ts"
cp "/tests/crates/biome_grit_patterns/tests/specs/ts/matchBacktickSnippet.ts" "crates/biome_grit_patterns/tests/specs/ts/matchBacktickSnippet.ts"
mkdir -p "crates/biome_grit_patterns/tests/specs/ts"
cp "/tests/crates/biome_grit_patterns/tests/specs/ts/matchStringLiteral.grit" "crates/biome_grit_patterns/tests/specs/ts/matchStringLiteral.grit"
mkdir -p "crates/biome_grit_patterns/tests/specs/ts"
cp "/tests/crates/biome_grit_patterns/tests/specs/ts/matchStringLiteral.snap" "crates/biome_grit_patterns/tests/specs/ts/matchStringLiteral.snap"
mkdir -p "crates/biome_grit_patterns/tests/specs/ts"
cp "/tests/crates/biome_grit_patterns/tests/specs/ts/matchStringLiteral.ts" "crates/biome_grit_patterns/tests/specs/ts/matchStringLiteral.ts"

# Rebuild the test binary after copying test files (tests are code-generated from spec files)
# Touch the test files to ensure cargo detects changes
touch crates/biome_grit_patterns/tests/spec_tests.rs
cargo test -p biome_grit_patterns --no-run 2>&1 | grep -v "^warning:" || true

# Run tests for the matchBacktickSnippet and matchStringLiteral test files
# The tests are auto-generated from the spec files, so we filter by the test name pattern
test_output=$(cargo test -p biome_grit_patterns -- match_backtick_snippet match_string_literal --nocapture 2>&1)
test_status=$?
echo "$test_output"

# Check if any tests actually ran (count total tests across all test suites)
total_tests=$(echo "$test_output" | grep "^running [0-9]* tests" | awk '{sum += $2} END {print sum}')
if [ "$total_tests" = "0" ] || [ -z "$total_tests" ]; then
  echo "ERROR: No tests ran for match_backtick_snippet or match_string_literal. Test files may be missing." >&2
  echo 0 > /logs/verifier/reward.txt
  exit 1
fi

if [ $test_status -eq 0 ]; then
  echo 1 > /logs/verifier/reward.txt
else
  echo 0 > /logs/verifier/reward.txt
fi
exit "$test_status"
