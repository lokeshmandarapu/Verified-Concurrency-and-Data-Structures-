#!/usr/bin/env bash
set -euo pipefail
cd "$(dirname "$0")/../verus"
cargo verus --features verifier
