#!/bin/bash

cd /app/src

# Copy HEAD test files from /tests (overwrites BASE state)
mkdir -p "test"
cp "/tests/kill.js" "test/kill.js"
mkdir -p "test/stdio"
cp "/tests/stdio/async.js" "test/stdio/async.js"
mkdir -p "test"
cp "/tests/stream.js" "test/stream.js"

# Create a custom test script that specifically tests for the bug:
# When stdin is destroyed, the subprocess should not hang forever.
# The buggy code will cause the subprocess to hang indefinitely.
cat > stdin_destroy_test.mjs << 'EOF'
import {execa} from './index.js';

async function test() {
  const childProcess = execa('test/fixtures/forever.js');

  // Set a timeout - if the process hangs for more than 5 seconds, it's the bug
  const timeoutId = setTimeout(() => {
    console.log('TEST FAILED: Process hangs when stdin is destroyed');
    process.exit(1);
  }, 5000);

  // Destroy stdin - this should cause the subprocess to exit (not hang)
  childProcess.stdin.destroy();

  try {
    await childProcess;
  } catch (err) {
    // Expected to throw with ERR_STREAM_PREMATURE_CLOSE in the fixed version
    clearTimeout(timeoutId);
    if (err.code === 'ERR_STREAM_PREMATURE_CLOSE') {
      console.log('TEST PASSED: Process exited correctly with ERR_STREAM_PREMATURE_CLOSE');
      process.exit(0);
    } else {
      // Any error is acceptable as long as it doesn't hang
      console.log('TEST PASSED: Process exited with error:', err.message);
      process.exit(0);
    }
  }

  // If we get here without error, it also means the process didn't hang
  clearTimeout(timeoutId);
  console.log('TEST PASSED: Process completed without hanging');
  process.exit(0);
}

test().catch(err => {
  console.error('Test error:', err);
  process.exit(1);
});
EOF

# Run the custom test that detects the bug
node stdin_destroy_test.mjs
test_status=$?

if [ $test_status -eq 0 ]; then
  echo 1 > /logs/verifier/reward.txt
else
  echo 0 > /logs/verifier/reward.txt
fi
exit "$test_status"
