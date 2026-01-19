#!/bin/bash

cd /app/src

# Validate that the generated grammars have the correct ordering
# The fix adds an override that moves LeftHandSideExpression -- alt1 to the END (after ++ and --)
# We check if alt1 appears AFTER the ++ and -- alternatives (which is CORRECT with the fix)
# Check ES2021 since that's one of the versions fixed (ES2022 was reverted in a later commit)
cd packages/es-grammars
if grep -B5 "| LeftHandSideExpression<guardYield, guardAwait> -- alt1" gen/es2021.grammar.ohm | grep -q "~lineTerminator \"--\" -- alt3"; then
    echo "Generated grammar has correct UpdateExpression ordering (fix applied)"
    test_status=0
else
    echo "Generated grammar has incorrect UpdateExpression ordering (fix not applied)"
    test_status=1
fi

if [ $test_status -eq 0 ]; then
  echo 1 > /logs/verifier/reward.txt
else
  echo 0 > /logs/verifier/reward.txt
fi
exit "$test_status"
