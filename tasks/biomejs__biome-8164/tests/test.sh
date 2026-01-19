#!/bin/bash

cd /app/src

export RUST_BACKTRACE=1

# Copy HEAD test files from /tests (overwrites BASE state)
mkdir -p "crates/biome_js_analyze/tests/specs/source/useSortedInterfaceMembers"
cp "/tests/crates/biome_js_analyze/tests/specs/source/useSortedInterfaceMembers/mixed_literals.ts" "crates/biome_js_analyze/tests/specs/source/useSortedInterfaceMembers/mixed_literals.ts"
mkdir -p "crates/biome_js_analyze/tests/specs/source/useSortedInterfaceMembers"
cp "/tests/crates/biome_js_analyze/tests/specs/source/useSortedInterfaceMembers/mixed_literals.ts.snap" "crates/biome_js_analyze/tests/specs/source/useSortedInterfaceMembers/mixed_literals.ts.snap"
mkdir -p "crates/biome_js_analyze/tests/specs/source/useSortedInterfaceMembers"
cp "/tests/crates/biome_js_analyze/tests/specs/source/useSortedInterfaceMembers/multiple_non_sortable.ts" "crates/biome_js_analyze/tests/specs/source/useSortedInterfaceMembers/multiple_non_sortable.ts"
mkdir -p "crates/biome_js_analyze/tests/specs/source/useSortedInterfaceMembers"
cp "/tests/crates/biome_js_analyze/tests/specs/source/useSortedInterfaceMembers/multiple_non_sortable.ts.snap" "crates/biome_js_analyze/tests/specs/source/useSortedInterfaceMembers/multiple_non_sortable.ts.snap"
mkdir -p "crates/biome_js_analyze/tests/specs/source/useSortedInterfaceMembers"
cp "/tests/crates/biome_js_analyze/tests/specs/source/useSortedInterfaceMembers/numeric_literals.ts" "crates/biome_js_analyze/tests/specs/source/useSortedInterfaceMembers/numeric_literals.ts"
mkdir -p "crates/biome_js_analyze/tests/specs/source/useSortedInterfaceMembers"
cp "/tests/crates/biome_js_analyze/tests/specs/source/useSortedInterfaceMembers/numeric_literals.ts.snap" "crates/biome_js_analyze/tests/specs/source/useSortedInterfaceMembers/numeric_literals.ts.snap"
mkdir -p "crates/biome_js_analyze/tests/specs/source/useSortedInterfaceMembers"
cp "/tests/crates/biome_js_analyze/tests/specs/source/useSortedInterfaceMembers/simple_comment.ts" "crates/biome_js_analyze/tests/specs/source/useSortedInterfaceMembers/simple_comment.ts"
mkdir -p "crates/biome_js_analyze/tests/specs/source/useSortedInterfaceMembers"
cp "/tests/crates/biome_js_analyze/tests/specs/source/useSortedInterfaceMembers/simple_comment.ts.snap" "crates/biome_js_analyze/tests/specs/source/useSortedInterfaceMembers/simple_comment.ts.snap"
mkdir -p "crates/biome_js_analyze/tests/specs/source/useSortedInterfaceMembers"
cp "/tests/crates/biome_js_analyze/tests/specs/source/useSortedInterfaceMembers/sortable_after_non_sortable.ts" "crates/biome_js_analyze/tests/specs/source/useSortedInterfaceMembers/sortable_after_non_sortable.ts"
mkdir -p "crates/biome_js_analyze/tests/specs/source/useSortedInterfaceMembers"
cp "/tests/crates/biome_js_analyze/tests/specs/source/useSortedInterfaceMembers/sortable_after_non_sortable.ts.snap" "crates/biome_js_analyze/tests/specs/source/useSortedInterfaceMembers/sortable_after_non_sortable.ts.snap"
mkdir -p "crates/biome_js_analyze/tests/specs/source/useSortedInterfaceMembers"
cp "/tests/crates/biome_js_analyze/tests/specs/source/useSortedInterfaceMembers/sorted.ts" "crates/biome_js_analyze/tests/specs/source/useSortedInterfaceMembers/sorted.ts"
mkdir -p "crates/biome_js_analyze/tests/specs/source/useSortedInterfaceMembers"
cp "/tests/crates/biome_js_analyze/tests/specs/source/useSortedInterfaceMembers/sorted.ts.snap" "crates/biome_js_analyze/tests/specs/source/useSortedInterfaceMembers/sorted.ts.snap"
mkdir -p "crates/biome_js_analyze/tests/specs/source/useSortedInterfaceMembers"
cp "/tests/crates/biome_js_analyze/tests/specs/source/useSortedInterfaceMembers/string_literals.ts" "crates/biome_js_analyze/tests/specs/source/useSortedInterfaceMembers/string_literals.ts"
mkdir -p "crates/biome_js_analyze/tests/specs/source/useSortedInterfaceMembers"
cp "/tests/crates/biome_js_analyze/tests/specs/source/useSortedInterfaceMembers/string_literals.ts.snap" "crates/biome_js_analyze/tests/specs/source/useSortedInterfaceMembers/string_literals.ts.snap"
mkdir -p "crates/biome_js_analyze/tests/specs/source/useSortedInterfaceMembers"
cp "/tests/crates/biome_js_analyze/tests/specs/source/useSortedInterfaceMembers/unsorted.ts" "crates/biome_js_analyze/tests/specs/source/useSortedInterfaceMembers/unsorted.ts"
mkdir -p "crates/biome_js_analyze/tests/specs/source/useSortedInterfaceMembers"
cp "/tests/crates/biome_js_analyze/tests/specs/source/useSortedInterfaceMembers/unsorted.ts.snap" "crates/biome_js_analyze/tests/specs/source/useSortedInterfaceMembers/unsorted.ts.snap"
mkdir -p "crates/biome_js_analyze/tests/specs/source/useSortedInterfaceMembers"
cp "/tests/crates/biome_js_analyze/tests/specs/source/useSortedInterfaceMembers/with_comments.ts" "crates/biome_js_analyze/tests/specs/source/useSortedInterfaceMembers/with_comments.ts"
mkdir -p "crates/biome_js_analyze/tests/specs/source/useSortedInterfaceMembers"
cp "/tests/crates/biome_js_analyze/tests/specs/source/useSortedInterfaceMembers/with_comments.ts.snap" "crates/biome_js_analyze/tests/specs/source/useSortedInterfaceMembers/with_comments.ts.snap"

# Run the specific test for useSortedInterfaceMembers
cargo test -p biome_js_analyze quick_test -- use_sorted_interface_members --nocapture

test_status=$?

if [ $test_status -eq 0 ]; then
  echo 1 > /logs/verifier/reward.txt
else
  echo 0 > /logs/verifier/reward.txt
fi
exit "$test_status"
