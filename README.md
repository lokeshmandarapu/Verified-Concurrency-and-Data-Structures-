# Formal Verification — Verus (Rust) and Dafny

Author: Lokesh Mandarapu  
License: CC0-1.0

This individual project demonstrates machine-checked correctness for two systems artifacts:
- Verus (Rust): minimal distributed lock service with specs and proofs
- Dafny: Linux-style doubly linked list and a fixed-size ring buffer with verified contracts

## Why this matters
Systems teams at Microsoft and Meta need correctness in kernels storage and networking. This repo shows spec writing proof structure and CI automation.

## Quickstart

### Verus (Rust) lock service
1. Install Rust https://rustup.rs
2. Install Verus https://github.com/verus-lang/verus
3. Verify and run:
   cd verus
   cargo verus --features verifier
   cargo run --example demo

### Dafny modules
1. Install Dafny https://dafny.org/dafny/
2. Verify:
   cd dafny
   dafny /compile:0 DList.dfy
   dafny /compile:0 RingBuffer.dfy

## Verification Results
After running the commands above add a screenshot of the successful run to docs/verification-success.png

![Verification success](docs/verification-success.png)

## Resume-ready summary
Formal Verification | Rust Verus Dafny
Verified a distributed lock service in Rust using Verus proving mutual exclusion and state invariants with machine checked specifications
Implemented and verified two data structures in Dafny a Linux style doubly linked list and a fixed size ring buffer maintaining five core invariants including acyclicity size accounting and capacity bounds
Automated verification with two GitHub Actions workflows that run on every commit and block merges on failures to prevent regressions
Authored concise design and proof documentation enumerating proof obligations assumptions and refinement boundaries to streamline reviews and future changes
