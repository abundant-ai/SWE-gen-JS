# SWE-gen JS

```
############################################################################
#   ______       _________        ____ ____  ____      ____ ______         #
#  / ___/ |     / / ____/  _____  / __ `/ _ \/ __ \      / // ___/         #
#  \__ \| | /| / / __/    /____/ / /_/ /  __/ / / /     / / \__ \          #
# ___/ /| |/ |/ / /___          \__, /\___/_/ /_/  |\__/ / ___/ /          #
#/____/ |__/|__/_____/         /____/              \___/  /____/           #
#                                                                          #
############################################################################
```

> 1000 JS/TS tasks generated from 30 open-source GitHub repos using [SWE-gen](https://github.com/abundant-ai/SWE-gen).

## Each task
- is a merged GitHub PR with linked Issues
- has 3-10 source files edited
- has Fail-to-Pass unit tests
- passes NOP (baseline fails) and Oracle (fix succeeds) validation
- follows the Harbor format

## Getting Started

Install [**Harbor**](https://github.com/laude-institute/harbor):

```shell
uv tool install harbor
```

Run the dataset oracle solutions to verify setup:

```shell
harbor run --dataset swe-gen-js \
   --agent oracle \
   --n-concurrent 4 
```

This command automatically downloads the tasks for the benchmark.

Run with Codex:

```shell
export OPENAI_API_KEY=<YOUR-KEY> 
harbor run --dataset swe-gen-js \
   --agent codex \
   --model openai/gpt-5.2-codex \
   --n-concurrent 4
```
