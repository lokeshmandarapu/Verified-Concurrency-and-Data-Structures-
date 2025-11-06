// DList.dfy — Minimal doubly linked list with verified operations

class Node {
  var prev: Node?
  var next: Node?
  var val: int

  constructor(v: int)
    ensures val == v && prev == null && next == null
  {
    val := v;
    prev := null;
    next := null;
  }
}

class DList {
  var head: Node?
  var tail: Node?
  var size: nat

  predicate Acyclic()
    reads this, head, tail
  {
    var steps := size;
    var n := head;
    while n != null && steps > 0
      decreases steps
    {
      n := n.next;
      steps := steps - 1;
    }
    n == null
  }

  constructor()
    ensures head == null && tail == null && size == 0 && Acyclic()
  {
    head := null;
    tail := null;
    size := 0;
  }

  method PushFront(v: int)
    modifies this, head, tail
    ensures size == old(size) + 1 && Acyclic()
  {
    var n := new Node(v);
    if head == null {
      head := n;
      tail := n;
    } else {
      n.next := head;
      head.prev := n;
      head := n;
    }
    size := size + 1;
  }

  method PopFront() returns (ok: bool, v: int)
    modifies this, head, tail
    ensures ok ==> size == old(size) - 1 && Acyclic()
    ensures !ok ==> size == old(size) && Acyclic()
  {
    if head == null {
      ok := false;
      v := 0;
      return;
    }
    ok := true;
    v := head.val;
    if head == tail {
      head := null;
      tail := null;
    } else {
      var n := head.next;
      n.prev := null;
      head := n;
    }
    size := size - 1;
  }
}
