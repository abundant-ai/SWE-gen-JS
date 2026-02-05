# SWE-gen JS

<p align="center">
  <a href="https://github.com/abundant-ai/SWE-gen-JS">
    <img src="assets/swegen-js-banner.jpg" style="height: 10em" alt="SWE-gen JS banner" />
  </a>
</p>

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

<p align="center">
  <img src="assets/pie_chart.png" style="height: 20em" alt="SWE-gen JS pie chart" />
</p>
