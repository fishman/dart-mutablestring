class FlatRope extends AbstractRope {
  final String _sequence;
  
  // constructor
  FlatRope(this._sequence){
    this._length = this._sequence.length;
  }
  
  String charAt(final int index) {
    return this._sequence[index];
  }

  int charCodeAt(int index) {
    return this._sequence.charCodeAt(index);
  }

  int depth() {
    return 0;
  }
  
  // TODO: iterator
//  public Iterator<Character> iterator(final int start) {
//    if (start < 0 || start >= length())
//      throw new IndexOutOfBoundsException("Rope index out of range: " + start);
//    return new Iterator<Character>() {
//      int current = start;
//      @Override
//      public boolean hasNext() {
//        return this.current < FlatRope.this.length();
//      }
//
//      @Override
//      public Character next() {
//        return FlatRope.this.sequence.charAt(this.current++);
//      }
//
//      @Override
//      public void remove() {
//        throw new UnsupportedOperationException("Rope iterator is read-only.");
//      }
//    };
//  }

  MutableString subSequence(final int start, final int end) {
    if (end - start < 8) {
      return new FlatRope(this._sequence.substring(start, end));
    } else {
      return new SubstringRope(this, start, end-start);
    }
  }
  
  String toString() {
    return this._sequence.toString();
  }
  
  MutableString rebalance() {
    return this;
  }
  
  // TODO: write
  // TODO: matcher

}

// vim:foldmethod=marker sw=2 sts=2 ts=2 tw=0 et ai nowrap
