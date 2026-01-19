#!/bin/bash

cd /app/src

# Copy HEAD test files from /tests (overwrites BASE state)
mkdir -p "test"
cp "/tests/kill.js" "test/kill.js"
mkdir -p "test/stdio"
cp "/tests/stdio/async.js" "test/stdio/async.js"

# Create a custom test script that specifically tests for the bug:
# When multiple error events are emitted on a subprocess, the buggy code
# will throw an uncaught exception because the error listener is removed after
# the first error.
cat > double_error_test.mjs << 'EOF'
import { once } from 'node:events';
import { setImmediate } from 'node:timers/promises';
import { execa } from './index.js';

// Set up to detect uncaught exceptions
let uncaughtOccurred = false;
process.on('uncaughtException', (err) => {
  uncaughtOccurred = true;
  console.error('UNCAUGHT EXCEPTION:', err.message);
});

async function test() {
  const abortController = new AbortController();
  const subprocess = execa('test/fixtures/forever.js', { signal: abortController.signal });

  await once(subprocess, 'spawn');

  // Emit first error - this should be handled
  subprocess.emit('error', new Error('first error'));

  await setImmediate();

  // Abort - this will emit a second error
  // In buggy code, this causes an uncaught exception
  abortController.abort();

  try {
    await subprocess;
  } catch (err) {
    // Expected to throw
  }

  // Give time for any uncaught exceptions to be processed
  await setImmediate();
  await setImmediate();

  if (uncaughtOccurred) {
    console.log('TEST FAILED: Uncaught exception occurred');
    process.exit(1);
  } else {
    console.log('TEST PASSED: No uncaught exception');
    process.exit(0);
  }
}

test().catch(err => {
  console.error('Test error:', err);
  process.exit(1);
});
EOF

# Run the custom test that detects the bug
node double_error_test.mjs
test_status=$?

if [ $test_status -eq 0 ]; then
  echo 1 > /logs/verifier/reward.txt
else
  echo 0 > /logs/verifier/reward.txt
fi
exit "$test_status"
