#!/bin/bash

cd /app/src

export RUST_BACKTRACE=1

# Copy HEAD test files from /tests (overwrites BASE state)
mkdir -p "crates/biome_js_analyze/tests/specs/nursery/noExcessiveLinesPerFile"
cp "/tests/crates/biome_js_analyze/tests/specs/nursery/noExcessiveLinesPerFile/empty.js" "crates/biome_js_analyze/tests/specs/nursery/noExcessiveLinesPerFile/empty.js"
mkdir -p "crates/biome_js_analyze/tests/specs/nursery/noExcessiveLinesPerFile"
cp "/tests/crates/biome_js_analyze/tests/specs/nursery/noExcessiveLinesPerFile/empty.js.snap" "crates/biome_js_analyze/tests/specs/nursery/noExcessiveLinesPerFile/empty.js.snap"
mkdir -p "crates/biome_js_analyze/tests/specs/nursery/noExcessiveLinesPerFile"
cp "/tests/crates/biome_js_analyze/tests/specs/nursery/noExcessiveLinesPerFile/empty.options.json" "crates/biome_js_analyze/tests/specs/nursery/noExcessiveLinesPerFile/empty.options.json"
mkdir -p "crates/biome_js_analyze/tests/specs/nursery/noExcessiveLinesPerFile"
cp "/tests/crates/biome_js_analyze/tests/specs/nursery/noExcessiveLinesPerFile/invalid.js" "crates/biome_js_analyze/tests/specs/nursery/noExcessiveLinesPerFile/invalid.js"
mkdir -p "crates/biome_js_analyze/tests/specs/nursery/noExcessiveLinesPerFile"
cp "/tests/crates/biome_js_analyze/tests/specs/nursery/noExcessiveLinesPerFile/invalid.js.snap" "crates/biome_js_analyze/tests/specs/nursery/noExcessiveLinesPerFile/invalid.js.snap"
mkdir -p "crates/biome_js_analyze/tests/specs/nursery/noExcessiveLinesPerFile"
cp "/tests/crates/biome_js_analyze/tests/specs/nursery/noExcessiveLinesPerFile/invalid.options.json" "crates/biome_js_analyze/tests/specs/nursery/noExcessiveLinesPerFile/invalid.options.json"
mkdir -p "crates/biome_js_analyze/tests/specs/nursery/noExcessiveLinesPerFile"
cp "/tests/crates/biome_js_analyze/tests/specs/nursery/noExcessiveLinesPerFile/invalidSkipBlankLines.js" "crates/biome_js_analyze/tests/specs/nursery/noExcessiveLinesPerFile/invalidSkipBlankLines.js"
mkdir -p "crates/biome_js_analyze/tests/specs/nursery/noExcessiveLinesPerFile"
cp "/tests/crates/biome_js_analyze/tests/specs/nursery/noExcessiveLinesPerFile/invalidSkipBlankLines.js.snap" "crates/biome_js_analyze/tests/specs/nursery/noExcessiveLinesPerFile/invalidSkipBlankLines.js.snap"
mkdir -p "crates/biome_js_analyze/tests/specs/nursery/noExcessiveLinesPerFile"
cp "/tests/crates/biome_js_analyze/tests/specs/nursery/noExcessiveLinesPerFile/invalidSkipBlankLines.options.json" "crates/biome_js_analyze/tests/specs/nursery/noExcessiveLinesPerFile/invalidSkipBlankLines.options.json"
mkdir -p "crates/biome_js_analyze/tests/specs/nursery/noExcessiveLinesPerFile"
cp "/tests/crates/biome_js_analyze/tests/specs/nursery/noExcessiveLinesPerFile/multipleStatementsSingleLine.js" "crates/biome_js_analyze/tests/specs/nursery/noExcessiveLinesPerFile/multipleStatementsSingleLine.js"
mkdir -p "crates/biome_js_analyze/tests/specs/nursery/noExcessiveLinesPerFile"
cp "/tests/crates/biome_js_analyze/tests/specs/nursery/noExcessiveLinesPerFile/multipleStatementsSingleLine.js.snap" "crates/biome_js_analyze/tests/specs/nursery/noExcessiveLinesPerFile/multipleStatementsSingleLine.js.snap"
mkdir -p "crates/biome_js_analyze/tests/specs/nursery/noExcessiveLinesPerFile"
cp "/tests/crates/biome_js_analyze/tests/specs/nursery/noExcessiveLinesPerFile/multipleStatementsSingleLine.options.json" "crates/biome_js_analyze/tests/specs/nursery/noExcessiveLinesPerFile/multipleStatementsSingleLine.options.json"
mkdir -p "crates/biome_js_analyze/tests/specs/nursery/noExcessiveLinesPerFile"
cp "/tests/crates/biome_js_analyze/tests/specs/nursery/noExcessiveLinesPerFile/singleLine.js" "crates/biome_js_analyze/tests/specs/nursery/noExcessiveLinesPerFile/singleLine.js"
mkdir -p "crates/biome_js_analyze/tests/specs/nursery/noExcessiveLinesPerFile"
cp "/tests/crates/biome_js_analyze/tests/specs/nursery/noExcessiveLinesPerFile/singleLine.js.snap" "crates/biome_js_analyze/tests/specs/nursery/noExcessiveLinesPerFile/singleLine.js.snap"
mkdir -p "crates/biome_js_analyze/tests/specs/nursery/noExcessiveLinesPerFile"
cp "/tests/crates/biome_js_analyze/tests/specs/nursery/noExcessiveLinesPerFile/singleLine.options.json" "crates/biome_js_analyze/tests/specs/nursery/noExcessiveLinesPerFile/singleLine.options.json"
mkdir -p "crates/biome_js_analyze/tests/specs/nursery/noExcessiveLinesPerFile"
cp "/tests/crates/biome_js_analyze/tests/specs/nursery/noExcessiveLinesPerFile/suppressed.js" "crates/biome_js_analyze/tests/specs/nursery/noExcessiveLinesPerFile/suppressed.js"
mkdir -p "crates/biome_js_analyze/tests/specs/nursery/noExcessiveLinesPerFile"
cp "/tests/crates/biome_js_analyze/tests/specs/nursery/noExcessiveLinesPerFile/suppressed.js.snap" "crates/biome_js_analyze/tests/specs/nursery/noExcessiveLinesPerFile/suppressed.js.snap"
mkdir -p "crates/biome_js_analyze/tests/specs/nursery/noExcessiveLinesPerFile"
cp "/tests/crates/biome_js_analyze/tests/specs/nursery/noExcessiveLinesPerFile/suppressed.options.json" "crates/biome_js_analyze/tests/specs/nursery/noExcessiveLinesPerFile/suppressed.options.json"
mkdir -p "crates/biome_js_analyze/tests/specs/nursery/noExcessiveLinesPerFile"
cp "/tests/crates/biome_js_analyze/tests/specs/nursery/noExcessiveLinesPerFile/valid.js" "crates/biome_js_analyze/tests/specs/nursery/noExcessiveLinesPerFile/valid.js"
mkdir -p "crates/biome_js_analyze/tests/specs/nursery/noExcessiveLinesPerFile"
cp "/tests/crates/biome_js_analyze/tests/specs/nursery/noExcessiveLinesPerFile/valid.js.snap" "crates/biome_js_analyze/tests/specs/nursery/noExcessiveLinesPerFile/valid.js.snap"
mkdir -p "crates/biome_js_analyze/tests/specs/nursery/noExcessiveLinesPerFile"
cp "/tests/crates/biome_js_analyze/tests/specs/nursery/noExcessiveLinesPerFile/valid.options.json" "crates/biome_js_analyze/tests/specs/nursery/noExcessiveLinesPerFile/valid.options.json"
mkdir -p "crates/biome_js_analyze/tests/specs/nursery/noExcessiveLinesPerFile"
cp "/tests/crates/biome_js_analyze/tests/specs/nursery/noExcessiveLinesPerFile/validSkipBlankLines.js" "crates/biome_js_analyze/tests/specs/nursery/noExcessiveLinesPerFile/validSkipBlankLines.js"
mkdir -p "crates/biome_js_analyze/tests/specs/nursery/noExcessiveLinesPerFile"
cp "/tests/crates/biome_js_analyze/tests/specs/nursery/noExcessiveLinesPerFile/validSkipBlankLines.js.snap" "crates/biome_js_analyze/tests/specs/nursery/noExcessiveLinesPerFile/validSkipBlankLines.js.snap"
mkdir -p "crates/biome_js_analyze/tests/specs/nursery/noExcessiveLinesPerFile"
cp "/tests/crates/biome_js_analyze/tests/specs/nursery/noExcessiveLinesPerFile/validSkipBlankLines.options.json" "crates/biome_js_analyze/tests/specs/nursery/noExcessiveLinesPerFile/validSkipBlankLines.options.json"

# Run only the snapshot tests for the noExcessiveLinesPerFile rule
# Filter tests by name to avoid running unrelated tests in the package
cargo test -p biome_js_analyze no_excessive_lines_per_file -- --nocapture
test_status=$?

if [ $test_status -eq 0 ]; then
  echo 1 > /logs/verifier/reward.txt
else
  echo 0 > /logs/verifier/reward.txt
fi
exit "$test_status"
