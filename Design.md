# Design and Specifications

## Verus Lock Service
State: owner: Option<u64>

Operations
- acquire(client) grants the lock if owner is None
- release(client) frees the lock only if client owns it

Invariants
- Mutual exclusion: at most one owner exists
- Well‑formed state: owner is None or Some(valid id)
