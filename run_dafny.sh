#!/usr/bin/env bash
set -euo pipefail
cd "$(dirname "$0")/../dafny"
dafny /compile:0 DList.dfy && dafny /compile:0 RingBuffer.dfy
