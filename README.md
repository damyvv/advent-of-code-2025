# Advent of Code 2025 — Workspace

Simple Ruby workspace helpers for Advent of Code inputs.

Usage

1. Copy `.env.example` to `.env` and fill your session cookie value:

```
cp .env.example .env
# edit .env and set AOC_SESSION
```

2. Download an input (day 1, year 2025):

```bash
./scripts/download_input.rb 1 2025
```

Or using an environment variable directly:

```bash
AOC_SESSION=your_session_here ./scripts/download_input.rb 1 2025
```

Inputs are saved under the `inputs/` directory as `day-01.txt`, etc.
