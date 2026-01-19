#!/bin/bash

cd /app/src

# Copy HEAD test files from /tests (overwrites BASE state)
mkdir -p "crates/turbopack-ecmascript/tests/analyzer/graph/conditional-import"
cp "/tests/crates/turbopack-ecmascript/tests/analyzer/graph/conditional-import/graph-effects.snapshot" "crates/turbopack-ecmascript/tests/analyzer/graph/conditional-import/graph-effects.snapshot"
mkdir -p "crates/turbopack-ecmascript/tests/analyzer/graph/conditional-import"
cp "/tests/crates/turbopack-ecmascript/tests/analyzer/graph/conditional-import/graph-explained.snapshot" "crates/turbopack-ecmascript/tests/analyzer/graph/conditional-import/graph-explained.snapshot"
mkdir -p "crates/turbopack-ecmascript/tests/analyzer/graph/conditional-import"
cp "/tests/crates/turbopack-ecmascript/tests/analyzer/graph/conditional-import/graph.snapshot" "crates/turbopack-ecmascript/tests/analyzer/graph/conditional-import/graph.snapshot"
mkdir -p "crates/turbopack-ecmascript/tests/analyzer/graph/conditional-import"
cp "/tests/crates/turbopack-ecmascript/tests/analyzer/graph/conditional-import/input.js" "crates/turbopack-ecmascript/tests/analyzer/graph/conditional-import/input.js"
mkdir -p "crates/turbopack-ecmascript/tests/analyzer/graph/conditional-import"
cp "/tests/crates/turbopack-ecmascript/tests/analyzer/graph/conditional-import/resolved-effects.snapshot" "crates/turbopack-ecmascript/tests/analyzer/graph/conditional-import/resolved-effects.snapshot"
mkdir -p "crates/turbopack-ecmascript/tests/analyzer/graph/conditional-import"
cp "/tests/crates/turbopack-ecmascript/tests/analyzer/graph/conditional-import/resolved-explained.snapshot" "crates/turbopack-ecmascript/tests/analyzer/graph/conditional-import/resolved-explained.snapshot"
mkdir -p "crates/turbopack-ecmascript/tests/analyzer/graph/md5_2"
cp "/tests/crates/turbopack-ecmascript/tests/analyzer/graph/md5_2/graph-explained.snapshot" "crates/turbopack-ecmascript/tests/analyzer/graph/md5_2/graph-explained.snapshot"
mkdir -p "crates/turbopack-ecmascript/tests/analyzer/graph/md5_2"
cp "/tests/crates/turbopack-ecmascript/tests/analyzer/graph/md5_2/graph.snapshot" "crates/turbopack-ecmascript/tests/analyzer/graph/md5_2/graph.snapshot"
mkdir -p "crates/turbopack-ecmascript/tests/analyzer/graph/md5_2"
cp "/tests/crates/turbopack-ecmascript/tests/analyzer/graph/md5_2/resolved-explained.snapshot" "crates/turbopack-ecmascript/tests/analyzer/graph/md5_2/resolved-explained.snapshot"
mkdir -p "crates/turbopack-ecmascript/tests/analyzer/graph/peg"
cp "/tests/crates/turbopack-ecmascript/tests/analyzer/graph/peg/graph-explained.snapshot" "crates/turbopack-ecmascript/tests/analyzer/graph/peg/graph-explained.snapshot"
mkdir -p "crates/turbopack-ecmascript/tests/analyzer/graph/peg"
cp "/tests/crates/turbopack-ecmascript/tests/analyzer/graph/peg/resolved-effects.snapshot" "crates/turbopack-ecmascript/tests/analyzer/graph/peg/resolved-effects.snapshot"
mkdir -p "crates/turbopack-ecmascript/tests/analyzer/graph/peg"
cp "/tests/crates/turbopack-ecmascript/tests/analyzer/graph/peg/resolved-explained.snapshot" "crates/turbopack-ecmascript/tests/analyzer/graph/peg/resolved-explained.snapshot"
mkdir -p "crates/turbopack-ecmascript/tests/analyzer/graph/react-dom-production"
cp "/tests/crates/turbopack-ecmascript/tests/analyzer/graph/react-dom-production/graph-explained.snapshot" "crates/turbopack-ecmascript/tests/analyzer/graph/react-dom-production/graph-explained.snapshot"
mkdir -p "crates/turbopack-ecmascript/tests/analyzer/graph/react-dom-production"
cp "/tests/crates/turbopack-ecmascript/tests/analyzer/graph/react-dom-production/resolved-effects.snapshot" "crates/turbopack-ecmascript/tests/analyzer/graph/react-dom-production/resolved-effects.snapshot"
mkdir -p "crates/turbopack-ecmascript/tests/analyzer/graph/react-dom-production"
cp "/tests/crates/turbopack-ecmascript/tests/analyzer/graph/react-dom-production/resolved-explained.snapshot" "crates/turbopack-ecmascript/tests/analyzer/graph/react-dom-production/resolved-explained.snapshot"

# Run cargo tests for the specific analyzer test cases
# These tests verify snapshot outputs for the ECMAScript analyzer graph
cargo test -p turbopack-ecmascript --lib -- conditional_import md5_2 peg react_dom_production
test_status=$?

if [ $test_status -eq 0 ]; then
  echo 1 > /logs/verifier/reward.txt
else
  echo 0 > /logs/verifier/reward.txt
fi
exit "$test_status"
