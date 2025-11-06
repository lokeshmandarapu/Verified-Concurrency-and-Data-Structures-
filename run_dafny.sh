#!/usr/bin/env bash
set -euo pipefail

script_dir="$(cd -- "$(dirname -- "$0")" && pwd)"
cd "$script_dir/../dafny"

dafny /compile:0 DList.dfy
dafny /compile:0 RingBuffer.dfy

