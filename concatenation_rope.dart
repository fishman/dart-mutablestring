class ConcatenationRope extends AbstractRope {
  final MutableString _left;
  final MutableString _right;
  int _depth;
  
  ConcatenationRope(this._left, this._right) {
    this._depth = (Math.max(Depth(this._left), Depth(this._right)));
    this._length = left.length + right.length;
  }
  
  
  int charCodeAt(final int index) {
    if (index < 0 || index >= this._length)
      throw new IndexOutOfRangeException(index);
    
    if (index < this._left.length)
      return this._left.charCodeAt(index);
    else
      return this._right.charCodeAt(index - this._left.length);
  }
  
  MutableString get left() => this._left;
  
  MutableString get right() => this._right; 
  
  // TODO: iterator
//    public Iterator<Character> iterator(final int start) {
//    if (start < 0 || start >= length())
//      throw new IndexOutOfBoundsException("Rope index out of range: " + start);
//    if (start >= this.left.length()) {
//      return this.right.iterator(start - this.left.length());
//    } else {
//      return new ConcatenationRopeIteratorImpl(this, start);
//    }
//  }

  MutableString subSequence(final int start, final int end) {
    if (start < 0 || end > this.length)
      throw new IllegalArgumentException("Illegal subsequence (" + start + "," + end + ")");
    final int l = this.left.length;
    if (end <= l)
      return this.left.subSequence(start, end);
    if (start >= l)
      return this.right.subSequence(start - l, end - l);
    return concatenate(
      this.left.subSequence(start, l),
      this.right.subSequence(0, end - l));
  }
  
  MutableString rebalance() {
    return Rebalance(this);
  }
  
  int depth(){
    return _depth;
  }

//  void write(Writer out) throws IOException {
//    left.write(out);
//    right.write(out);
//  }
//
//  void write(Writer out, int offset, int length) throws IOException {
//    if (offset + length < left.length()) {
//      left.write(out, offset, length);
//    } else if (offset >= left.length()) {
//      right.write(out, offset - left.length(), length);
//    } else {
//      int writeLeft = left.length() - offset;
//      left.write(out, offset, writeLeft);
//      right.write(out, 0, right.length() - writeLeft);
//    }
//  }


}

// vim:foldmethod=marker sw=2 sts=2 ts=2 tw=0 et ai nowrap
