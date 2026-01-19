#!/bin/bash

cd /app/src

# Test the default value of perMessageDeflate directly
# This test will FAIL if default is true (buggy), PASS if default is false (fixed)
node -e "
const WebSocket = require('./index');
const options = { port: 0 };
// Create a temporary server to check default options
const wss = new WebSocket.Server(options);
const defaultValue = wss.options.perMessageDeflate;
wss.close();

console.log('perMessageDeflate default:', defaultValue);

// Test passes if default is false (fixed behavior)
// Test fails if default is true (buggy behavior)
if (defaultValue === false) {
  console.log('PASS: perMessageDeflate is disabled by default (correct)');
  process.exit(0);
} else {
  console.log('FAIL: perMessageDeflate is enabled by default (incorrect)');
  process.exit(1);
}
"
test_status=$?

if [ $test_status -eq 0 ]; then
  echo 1 > /logs/verifier/reward.txt
else
  echo 0 > /logs/verifier/reward.txt
fi
exit "$test_status"
