class RopeIterator implements Iterator<MutableString> {
  MutableString currentRope;
  int currentRopePos;
  int currentAbsolutePos;
  int _skip;
  Queue<MutableString> toTraverse;

  RopeIterator(final MutableString rope, [int start = 0]){
    toTraverse = new Queue<MutableString>();
    toTraverse.add(rope);
    currentRope = null;
    skip = 0;
    initialize();

    if (start < 0 || start > rope.length - 1) {
      throw new IllegalArgumentException("Rope index out of range" + start.toString());
    }
    moveForward(start);
  }

  bool hasNext(){
    return currentRopePos < currentRope.length - 1 || !toTraverse.isEmpty();
  }

  MutableString next(){
    moveForward(1 + skip);
    skip = 0;
    return this.currentRope.charCodeAt(currentRopePos);
  }

  initialize(){
    while (!toTraverse.isEmpty()) {
      currentRope = toTraverse.removeFirst();
      if (currentRope is ConcatenationRope) {
        toTraverse.push(currentRope.getRight());
        toTraverse.push(currentRope.getLeft());
      } else {
        break;
      }
    }
    if (currentRope == null)
      throw new IllegalArgumentException("No terminal ropes present.");
    currentRopePos = -1;
    currentAbsolutePos = -1;
  }

  bool canMoveBackwards(final int amount){
    return (-1 <= (currentRopePos - amount));
  }

  moveBackwards(final int amount) {
    if (!canMoveBackwards(amount)) 
      throw new IllegalArgumentException("Unable to move backwards " + amount + ".");
    currentRopePos -= amount;
    currentAbsolutePos -= amount;
  }

  moveForward(final int amount) {
    this.currentAbsolutePos += amount;
    int remainingAmt = amount;
    while (remainingAmt != 0) {
      if (remainingAmt + currentRopePos < currentRope.length) {
        currentRopePos += remainingAmt;
        return;
      }
      remainingAmt = remainingAmt - (currentRope.length - (currentRopePos + 1));
      if (remainingAmt > 0 && toTraverse.isEmpty())
        throw new IllegalArgumentException("Unable to move forward " + amount + ". Reached end of rope.");

      while (!toTraverse.isEmpty()) {
        currentRope = toTraverse.removeFirst();
        if (currentRope is ConcatenationRope) {
          toTraverse.push(currentRope.getRight());
          toTraverse.push(currentRope.getLeft());
        } else {
          currentRopePos = -1;
          break;
        }
      }
    }
  }

  set skip(int s){
    _skip = s;
  }

  int get skip() => _skip;
  // TODO: currentpos should be private
  int get pos() => currentAbsolutePos;

  remove(){
    throw new UnsupportedOperationException("Rope iterator is read-only.");
  }

}

// vim:foldmethod=marker sw=2 sts=2 ts=2 tw=0 et ai nowrap
