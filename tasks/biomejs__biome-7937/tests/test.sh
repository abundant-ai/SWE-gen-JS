#!/bin/bash

cd /app/src

export RUST_BACKTRACE=1

# Copy HEAD test files from /tests (overwrites BASE state)
mkdir -p "crates/biome_tailwind_parser/src/lexer"
cp "/tests/crates/biome_tailwind_parser/src/lexer/tests.rs" "crates/biome_tailwind_parser/src/lexer/tests.rs"
mkdir -p "crates/biome_tailwind_parser/tests/tailwind_specs/error/arbitrary-candidate"
cp "/tests/crates/biome_tailwind_parser/tests/tailwind_specs/error/arbitrary-candidate/missing-property.txt.snap" "crates/biome_tailwind_parser/tests/tailwind_specs/error/arbitrary-candidate/missing-property.txt.snap"
mkdir -p "crates/biome_tailwind_parser/tests/tailwind_specs/error/arbitrary-candidate"
cp "/tests/crates/biome_tailwind_parser/tests/tailwind_specs/error/arbitrary-candidate/missing-value-in-arbitrary.txt.snap" "crates/biome_tailwind_parser/tests/tailwind_specs/error/arbitrary-candidate/missing-value-in-arbitrary.txt.snap"
mkdir -p "crates/biome_tailwind_parser/tests/tailwind_specs/error"
cp "/tests/crates/biome_tailwind_parser/tests/tailwind_specs/error/incomplete-arbitrary-value-0.txt.snap" "crates/biome_tailwind_parser/tests/tailwind_specs/error/incomplete-arbitrary-value-0.txt.snap"
mkdir -p "crates/biome_tailwind_parser/tests/tailwind_specs/error"
cp "/tests/crates/biome_tailwind_parser/tests/tailwind_specs/error/incomplete-arbitrary-value-1.txt.snap" "crates/biome_tailwind_parser/tests/tailwind_specs/error/incomplete-arbitrary-value-1.txt.snap"
mkdir -p "crates/biome_tailwind_parser/tests/tailwind_specs/error"
cp "/tests/crates/biome_tailwind_parser/tests/tailwind_specs/error/incomplete-arbitrary-value-2.txt.snap" "crates/biome_tailwind_parser/tests/tailwind_specs/error/incomplete-arbitrary-value-2.txt.snap"
mkdir -p "crates/biome_tailwind_parser/tests/tailwind_specs/error"
cp "/tests/crates/biome_tailwind_parser/tests/tailwind_specs/error/incomplete-arbitrary-variant.txt.snap" "crates/biome_tailwind_parser/tests/tailwind_specs/error/incomplete-arbitrary-variant.txt.snap"
mkdir -p "crates/biome_tailwind_parser/tests/tailwind_specs/error"
cp "/tests/crates/biome_tailwind_parser/tests/tailwind_specs/error/missing-modifier-value-1.txt.snap" "crates/biome_tailwind_parser/tests/tailwind_specs/error/missing-modifier-value-1.txt.snap"
mkdir -p "crates/biome_tailwind_parser/tests/tailwind_specs/error"
cp "/tests/crates/biome_tailwind_parser/tests/tailwind_specs/error/missing-modifier-value.txt.snap" "crates/biome_tailwind_parser/tests/tailwind_specs/error/missing-modifier-value.txt.snap"
mkdir -p "crates/biome_tailwind_parser/tests/tailwind_specs/error"
cp "/tests/crates/biome_tailwind_parser/tests/tailwind_specs/error/missing-value.txt.snap" "crates/biome_tailwind_parser/tests/tailwind_specs/error/missing-value.txt.snap"
mkdir -p "crates/biome_tailwind_parser/tests/tailwind_specs/ok/brackets"
cp "/tests/crates/biome_tailwind_parser/tests/tailwind_specs/ok/brackets/gradient.txt.snap" "crates/biome_tailwind_parser/tests/tailwind_specs/ok/brackets/gradient.txt.snap"
mkdir -p "crates/biome_tailwind_parser/tests/tailwind_specs/ok/brackets"
cp "/tests/crates/biome_tailwind_parser/tests/tailwind_specs/ok/brackets/image-url.txt.snap" "crates/biome_tailwind_parser/tests/tailwind_specs/ok/brackets/image-url.txt.snap"
mkdir -p "crates/biome_tailwind_parser/tests/tailwind_specs/ok/brackets"
cp "/tests/crates/biome_tailwind_parser/tests/tailwind_specs/ok/brackets/shadow.txt.snap" "crates/biome_tailwind_parser/tests/tailwind_specs/ok/brackets/shadow.txt.snap"
mkdir -p "crates/biome_tailwind_parser/tests/tailwind_specs/ok/candidates"
cp "/tests/crates/biome_tailwind_parser/tests/tailwind_specs/ok/candidates/arbitrary-candidate-0.txt.snap" "crates/biome_tailwind_parser/tests/tailwind_specs/ok/candidates/arbitrary-candidate-0.txt.snap"
mkdir -p "crates/biome_tailwind_parser/tests/tailwind_specs/ok/candidates"
cp "/tests/crates/biome_tailwind_parser/tests/tailwind_specs/ok/candidates/arbitrary-candidate-1.txt.snap" "crates/biome_tailwind_parser/tests/tailwind_specs/ok/candidates/arbitrary-candidate-1.txt.snap"
mkdir -p "crates/biome_tailwind_parser/tests/tailwind_specs/ok/candidates"
cp "/tests/crates/biome_tailwind_parser/tests/tailwind_specs/ok/candidates/arbitrary-candidate-2.txt.snap" "crates/biome_tailwind_parser/tests/tailwind_specs/ok/candidates/arbitrary-candidate-2.txt.snap"
mkdir -p "crates/biome_tailwind_parser/tests/tailwind_specs/ok/candidates"
cp "/tests/crates/biome_tailwind_parser/tests/tailwind_specs/ok/candidates/arbitrary-candidate-3.txt.snap" "crates/biome_tailwind_parser/tests/tailwind_specs/ok/candidates/arbitrary-candidate-3.txt.snap"
mkdir -p "crates/biome_tailwind_parser/tests/tailwind_specs/ok/gradients"
cp "/tests/crates/biome_tailwind_parser/tests/tailwind_specs/ok/gradients/precise-control.txt" "crates/biome_tailwind_parser/tests/tailwind_specs/ok/gradients/precise-control.txt"
mkdir -p "crates/biome_tailwind_parser/tests/tailwind_specs/ok/gradients"
cp "/tests/crates/biome_tailwind_parser/tests/tailwind_specs/ok/gradients/precise-control.txt.snap" "crates/biome_tailwind_parser/tests/tailwind_specs/ok/gradients/precise-control.txt.snap"
mkdir -p "crates/biome_tailwind_parser/tests/tailwind_specs/ok/gradients"
cp "/tests/crates/biome_tailwind_parser/tests/tailwind_specs/ok/gradients/simple.txt" "crates/biome_tailwind_parser/tests/tailwind_specs/ok/gradients/simple.txt"
mkdir -p "crates/biome_tailwind_parser/tests/tailwind_specs/ok/gradients"
cp "/tests/crates/biome_tailwind_parser/tests/tailwind_specs/ok/gradients/simple.txt.snap" "crates/biome_tailwind_parser/tests/tailwind_specs/ok/gradients/simple.txt.snap"
mkdir -p "crates/biome_tailwind_parser/tests/tailwind_specs/ok/simple"
cp "/tests/crates/biome_tailwind_parser/tests/tailwind_specs/ok/simple/arbitrary-value-0.txt.snap" "crates/biome_tailwind_parser/tests/tailwind_specs/ok/simple/arbitrary-value-0.txt.snap"

# Run the biome_tailwind_parser lexer tests
cargo test -p biome_tailwind_parser --lib lexer -- --nocapture
test_status=$?

if [ $test_status -eq 0 ]; then
  echo 1 > /logs/verifier/reward.txt
else
  echo 0 > /logs/verifier/reward.txt
fi
exit "$test_status"
