// RingBuffer.dfy — Fixed-size ring buffer with verified contracts

class RingBuffer {
  var buf: array<int>
  var head: nat
  var tail: nat
  var cap: nat
  var count: nat

  predicate WellFormed()
    reads this, buf
  {
    buf != null && cap == buf.Length &&
    head < cap && tail < cap &&
    count <= cap
  }

  constructor(capacity: nat)
    requires capacity > 0
    ensures cap == capacity && count == 0 && head == 0 && tail == 0 && WellFormed()
  {
    buf := new int[capacity];
    cap := capacity;
    head := 0;
    tail := 0;
    count := 0;
  }

  method Enqueue(x: int) returns (ok: bool)
    modifies this, buf
    requires WellFormed()
    ensures WellFormed()
    ensures ok ==> count == old(count) + 1
    ensures !ok ==> count == old(count)
  {
    if count == cap {
      ok := false;
      return;
    }
    buf[tail] := x;
    tail := (tail + 1) % cap;
    count := count + 1;
    ok := true;
  }

  method Dequeue() returns (ok: bool, x: int)
    modifies this
    requires WellFormed()
    ensures WellFormed()
    ensures ok ==> count == old(count) - 1
    ensures !ok ==> count == old(count)
  {
    if count == 0 {
      ok := false;
      x := 0;
      return;
    }
    x := buf[head];
    head := (head + 1) % cap;
    count := count - 1;
    ok := true;
  }
}
