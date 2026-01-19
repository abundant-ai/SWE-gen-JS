#!/bin/bash

cd /app/src

# Copy HEAD test files from /tests (overwrites BASE state)
# No test files to copy

# This PR removes the internal consistent-meta-messages rule and adopts the public prefer-message-ids rule.
# Verify that the internal rule has been removed (exists in BASE/buggy state, removed in FIXED state).
if [ -f "tools/internal-rules/consistent-meta-messages.js" ]; then
    # Internal rule still exists - this is the buggy state
    echo 0 > /logs/verifier/reward.txt
    exit 1
else
    # Internal rule has been removed - this is the fixed state
    echo 1 > /logs/verifier/reward.txt
    exit 0
fi
