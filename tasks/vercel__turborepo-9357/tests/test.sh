#!/bin/bash

cd /app/src

# Copy HEAD test files from /tests (overwrites BASE state)
mkdir -p "crates/turborepo/tests"
cp "/tests/crates/turborepo/tests/query.rs" "crates/turborepo/tests/query.rs"
mkdir -p "crates/turborepo/tests/snapshots"
cp '/tests/crates/turborepo/tests/snapshots/query__turbo_trace_get_`import_value_and_type.ts`_with_all_dependencies_(npm@10.5.0).snap' 'crates/turborepo/tests/snapshots/query__turbo_trace_get_`import_value_and_type.ts`_with_all_dependencies_(npm@10.5.0).snap'
mkdir -p "crates/turborepo/tests/snapshots"
cp '/tests/crates/turborepo/tests/snapshots/query__turbo_trace_get_`import_value_and_type.ts`_with_type_dependencies_(npm@10.5.0).snap' 'crates/turborepo/tests/snapshots/query__turbo_trace_get_`import_value_and_type.ts`_with_type_dependencies_(npm@10.5.0).snap'
mkdir -p "crates/turborepo/tests/snapshots"
cp '/tests/crates/turborepo/tests/snapshots/query__turbo_trace_get_`import_value_and_type.ts`_with_value_dependencies_(npm@10.5.0).snap' 'crates/turborepo/tests/snapshots/query__turbo_trace_get_`import_value_and_type.ts`_with_value_dependencies_(npm@10.5.0).snap'
mkdir -p "crates/turborepo/tests/snapshots"
cp '/tests/crates/turborepo/tests/snapshots/query__turbo_trace_get_`link.tsx`_with_all_dependents_(npm@10.5.0).snap' 'crates/turborepo/tests/snapshots/query__turbo_trace_get_`link.tsx`_with_all_dependents_(npm@10.5.0).snap'
mkdir -p "crates/turborepo/tests/snapshots"
cp '/tests/crates/turborepo/tests/snapshots/query__turbo_trace_get_`link.tsx`_with_type_dependents_(npm@10.5.0).snap' 'crates/turborepo/tests/snapshots/query__turbo_trace_get_`link.tsx`_with_type_dependents_(npm@10.5.0).snap'
mkdir -p "crates/turborepo/tests/snapshots"
cp '/tests/crates/turborepo/tests/snapshots/query__turbo_trace_get_`link.tsx`_with_value_dependents_(npm@10.5.0).snap' 'crates/turborepo/tests/snapshots/query__turbo_trace_get_`link.tsx`_with_value_dependents_(npm@10.5.0).snap'

# Run specific test file with cargo test (this will build and test)
cargo test --test query -- --nocapture
test_status=$?

if [ $test_status -eq 0 ]; then
  echo 1 > /logs/verifier/reward.txt
else
  echo 0 > /logs/verifier/reward.txt
fi
exit "$test_status"
