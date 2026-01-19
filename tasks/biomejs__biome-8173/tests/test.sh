#!/bin/bash

cd /app/src

export RUST_BACKTRACE=1

# Remove test files that were added by bug.patch but don't exist in HEAD
rm -f "crates/biome_js_analyze/tests/specs/correctness/noUnusedPrivateClassMembers/invalid_aligned_with_semantic_class.ts"
rm -f "crates/biome_js_analyze/tests/specs/correctness/noUnusedPrivateClassMembers/invalid_aligned_with_semantic_class.ts.snap"
rm -f "crates/biome_js_analyze/tests/specs/correctness/noUnusedPrivateClassMembers/valid_aligned_with_semantic_class.js"
rm -f "crates/biome_js_analyze/tests/specs/correctness/noUnusedPrivateClassMembers/valid_aligned_with_semantic_class.js.snap"

# Copy HEAD test files from /tests (overwrites BASE state)
mkdir -p "crates/biome_js_analyze/tests/specs/correctness/noUnusedPrivateClassMembers"
cp "/tests/crates/biome_js_analyze/tests/specs/correctness/noUnusedPrivateClassMembers/invalid.js" "crates/biome_js_analyze/tests/specs/correctness/noUnusedPrivateClassMembers/invalid.js"
mkdir -p "crates/biome_js_analyze/tests/specs/correctness/noUnusedPrivateClassMembers"
cp "/tests/crates/biome_js_analyze/tests/specs/correctness/noUnusedPrivateClassMembers/invalid.js.snap" "crates/biome_js_analyze/tests/specs/correctness/noUnusedPrivateClassMembers/invalid.js.snap"
mkdir -p "crates/biome_js_analyze/tests/specs/correctness/noUnusedPrivateClassMembers"
cp "/tests/crates/biome_js_analyze/tests/specs/correctness/noUnusedPrivateClassMembers/invalid.ts" "crates/biome_js_analyze/tests/specs/correctness/noUnusedPrivateClassMembers/invalid.ts"
mkdir -p "crates/biome_js_analyze/tests/specs/correctness/noUnusedPrivateClassMembers"
cp "/tests/crates/biome_js_analyze/tests/specs/correctness/noUnusedPrivateClassMembers/invalid.ts.snap" "crates/biome_js_analyze/tests/specs/correctness/noUnusedPrivateClassMembers/invalid.ts.snap"
mkdir -p "crates/biome_js_analyze/tests/specs/correctness/noUnusedPrivateClassMembers"
cp "/tests/crates/biome_js_analyze/tests/specs/correctness/noUnusedPrivateClassMembers/invalid_dynamic_access.ts" "crates/biome_js_analyze/tests/specs/correctness/noUnusedPrivateClassMembers/invalid_dynamic_access.ts"
mkdir -p "crates/biome_js_analyze/tests/specs/correctness/noUnusedPrivateClassMembers"
cp "/tests/crates/biome_js_analyze/tests/specs/correctness/noUnusedPrivateClassMembers/invalid_dynamic_access.ts.snap" "crates/biome_js_analyze/tests/specs/correctness/noUnusedPrivateClassMembers/invalid_dynamic_access.ts.snap"
mkdir -p "crates/biome_js_analyze/tests/specs/correctness/noUnusedPrivateClassMembers"
cp "/tests/crates/biome_js_analyze/tests/specs/correctness/noUnusedPrivateClassMembers/invalid_issue_7101.ts" "crates/biome_js_analyze/tests/specs/correctness/noUnusedPrivateClassMembers/invalid_issue_7101.ts"
mkdir -p "crates/biome_js_analyze/tests/specs/correctness/noUnusedPrivateClassMembers"
cp "/tests/crates/biome_js_analyze/tests/specs/correctness/noUnusedPrivateClassMembers/invalid_issue_7101.ts.snap" "crates/biome_js_analyze/tests/specs/correctness/noUnusedPrivateClassMembers/invalid_issue_7101.ts.snap"
mkdir -p "crates/biome_js_analyze/tests/specs/correctness/noUnusedPrivateClassMembers"
cp "/tests/crates/biome_js_analyze/tests/specs/correctness/noUnusedPrivateClassMembers/valid.js" "crates/biome_js_analyze/tests/specs/correctness/noUnusedPrivateClassMembers/valid.js"
mkdir -p "crates/biome_js_analyze/tests/specs/correctness/noUnusedPrivateClassMembers"
cp "/tests/crates/biome_js_analyze/tests/specs/correctness/noUnusedPrivateClassMembers/valid.js.snap" "crates/biome_js_analyze/tests/specs/correctness/noUnusedPrivateClassMembers/valid.js.snap"
mkdir -p "crates/biome_js_analyze/tests/specs/correctness/noUnusedPrivateClassMembers"
cp "/tests/crates/biome_js_analyze/tests/specs/correctness/noUnusedPrivateClassMembers/valid_dynamic_access.ts" "crates/biome_js_analyze/tests/specs/correctness/noUnusedPrivateClassMembers/valid_dynamic_access.ts"
mkdir -p "crates/biome_js_analyze/tests/specs/correctness/noUnusedPrivateClassMembers"
cp "/tests/crates/biome_js_analyze/tests/specs/correctness/noUnusedPrivateClassMembers/valid_dynamic_access.ts.snap" "crates/biome_js_analyze/tests/specs/correctness/noUnusedPrivateClassMembers/valid_dynamic_access.ts.snap"

# Build the tests after copying test files (tests are generated at compile time from file structure)
cargo test --no-run -p biome_js_analyze --test spec_tests

# Run the specific tests for noUnusedPrivateClassMembers
cargo test -p biome_js_analyze --test spec_tests -- specs::correctness::no_unused_private_class_members --nocapture
test_status=$?

if [ $test_status -eq 0 ]; then
  echo 1 > /logs/verifier/reward.txt
else
  echo 0 > /logs/verifier/reward.txt
fi
exit "$test_status"
