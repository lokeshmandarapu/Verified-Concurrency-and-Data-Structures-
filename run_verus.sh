#!/usr/bin/env bash
set -euo pipefail

script_dir="$(cd -- "$(dirname -- "$0")" && pwd)"
cd "$script_dir/../verus"

# sanity checks
if ! command -v cargo >/dev/null 2>&1; then
  echo "cargo not found; install Rust (https://rustup.rs)"; exit 1
fi
if ! cargo --list | grep -qE '^\s+verus\b'; then
  echo "'cargo verus' not found; install Verus (https://github.com/verus-lang/verus)"; exit 1
fi

echo "Running Verus verification…"
time cargo verus --features verifier

