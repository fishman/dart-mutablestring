class SubstringRope extends AbstractRope {
  final FlatRope _rope;
  final int _offset;
  int _depth;
  
  SubstringRope(FlatRope this._rope, int this._offset, int length) {
    this._length = length;
    if (this._length < 0 || this._offset < 0 || this._offset + this.length > this._rope.length)
      throw new IndexOutOfRangeException(this._offset);
    
    this._depth  = this._rope.depth() + 1;
  }

  int charCodeAt(final int index) {
    return this._rope.charCodeAt(this._offset + index);
  }
  
  int depth(){
    return _depth;
  }
  
  int getOffset(){
    return _offset;
  }
  
  MutableString getRope(){
    return _rope;
  }
  
  Iterator<MutableString> iterator(int start) {
    
  }
  // TODO: iterator
//    public Iterator<Character> iterator(final int start) {
//    if (start < 0 || start >= length())
//      throw new IndexOutOfBoundsException("Rope index out of range: " + start);
//    return this.rope.iterator(this.offset + start);
//  }

  MutableString subSequence(final int start, final int end) {
    return new SubstringRope(_rope, _offset + start, end-start);
  }
  
  String toString() {
    return _rope.toSubString(_offset, _length);
  }
  
  MutableString rebalance() {
    return this;
  }
  
  //TODO: write
  //TODO: matcher
}

// vim:foldmethod=marker sw=2 sts=2 ts=2 tw=0 et ai nowrap
