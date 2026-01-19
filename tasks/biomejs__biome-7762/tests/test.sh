#!/bin/bash

cd /app/src

export RUST_BACKTRACE=1

# Copy HEAD test files from /tests (overwrites BASE state)
mkdir -p "crates/biome_js_analyze/tests/specs/correctness/useImportExtensions"
cp "/tests/crates/biome_js_analyze/tests/specs/correctness/useImportExtensions/bar.ts" "crates/biome_js_analyze/tests/specs/correctness/useImportExtensions/bar.ts"
mkdir -p "crates/biome_js_analyze/tests/specs/correctness/useImportExtensions"
cp "/tests/crates/biome_js_analyze/tests/specs/correctness/useImportExtensions/bar.ts.snap" "crates/biome_js_analyze/tests/specs/correctness/useImportExtensions/bar.ts.snap"
mkdir -p "crates/biome_js_analyze/tests/specs/correctness/useImportExtensions"
cp "/tests/crates/biome_js_analyze/tests/specs/correctness/useImportExtensions/foo.ts" "crates/biome_js_analyze/tests/specs/correctness/useImportExtensions/foo.ts"
mkdir -p "crates/biome_js_analyze/tests/specs/correctness/useImportExtensions"
cp "/tests/crates/biome_js_analyze/tests/specs/correctness/useImportExtensions/foo.ts.snap" "crates/biome_js_analyze/tests/specs/correctness/useImportExtensions/foo.ts.snap"
mkdir -p "crates/biome_js_analyze/tests/specs/correctness/useImportExtensions"
cp "/tests/crates/biome_js_analyze/tests/specs/correctness/useImportExtensions/invalidWithExtensionMappings.options.json" "crates/biome_js_analyze/tests/specs/correctness/useImportExtensions/invalidWithExtensionMappings.options.json"
mkdir -p "crates/biome_js_analyze/tests/specs/correctness/useImportExtensions"
cp "/tests/crates/biome_js_analyze/tests/specs/correctness/useImportExtensions/invalidWithExtensionMappings.ts" "crates/biome_js_analyze/tests/specs/correctness/useImportExtensions/invalidWithExtensionMappings.ts"
mkdir -p "crates/biome_js_analyze/tests/specs/correctness/useImportExtensions"
cp "/tests/crates/biome_js_analyze/tests/specs/correctness/useImportExtensions/invalidWithExtensionMappings.ts.snap" "crates/biome_js_analyze/tests/specs/correctness/useImportExtensions/invalidWithExtensionMappings.ts.snap"

# Rebuild the test binary after copying test files (tests are code-generated from spec files)
# Touch the test files to ensure cargo detects changes
touch crates/biome_js_analyze/tests/spec_tests.rs
cargo test -p biome_js_analyze --no-run 2>&1 | grep -v "^warning:" || true

# Run tests for the useImportExtensions test files
# The tests are auto-generated from the spec files, so we filter by the test name pattern
test_output=$(cargo test -p biome_js_analyze -- use_import_extensions --nocapture 2>&1)
test_status=$?
echo "$test_output"

# Check if any tests actually ran (count total tests across all test suites)
total_tests=$(echo "$test_output" | grep "^running [0-9]* tests" | awk '{sum += $2} END {print sum}')
if [ "$total_tests" = "0" ] || [ -z "$total_tests" ]; then
  echo "ERROR: No tests ran for use_import_extensions. Test files may be missing." >&2
  echo 0 > /logs/verifier/reward.txt
  exit 1
fi

if [ $test_status -eq 0 ]; then
  echo 1 > /logs/verifier/reward.txt
else
  echo 0 > /logs/verifier/reward.txt
fi
exit "$test_status"
