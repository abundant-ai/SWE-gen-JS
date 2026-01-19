#!/usr/bin/env node
import process from 'node:process';
import {writeSync} from 'node:fs';

writeSync(Number(process.argv[2]), 'foobar');
process.exit(2);
