class AbstractRope implements Rope {
  int _hashCode = 0;
  int _length;

  int get length() => _length;
  
  abstract int charCodeAt(int index);
  
  Rope append(String c) {
    return concatenate(this, build(c));
  }
  
  Rope appendSubstr(String c, final int start, final int end) {
    return concatenate(this, build(c).subSequence(start, end));
  }
  
  Rope appendRope(Rope r) {
    return concatenate(this, r);
  }
  
  Rope delete(final int start, final int end){
    if (start == end)
      return this;
    return this.subSequence(0, start).appendRope(this.subSequence(end, this.length));
  }
  
  
  // TODO: add comparison later
  int hashCode() {
    if (this._hashCode == 0 && length > 0) {
      List<int> cc = this.charCodes();

      if (this is FlatRope) {
//        this._hashCode = this.
      } else if (this.length < 6) {
        //TODO: fix hashCode generation
//        for (int j = 0; j < length ; ++j) {
//          this._hashCode = 31 * this._hashCode + cc[charCodes[i]];
//        }
        // TODO: check if charcodes list is an efficient way to generate the hash
       // for ()
// TODO:       for (final char c: this)
//          this._hashCode = 31 * this._hashCode + c;
      } else {
        // TODO: final Iterator<Character> i = this.iterator();
        // for (int j=0;j<5; ++j)
         //  this._hashCode = 31 * this._hashCode + i.next();
        this._hashCode = 31 * this._hashCode + this.charCodeAt(this.length - 1);
        
      }
    }
    return this._hashCode;
  }
  
  bool equals(final Object other){
    if (other is Rope) {
      final Rope rope = other;
      //TODO: lazy comparison, no hash compare if (rope.hashCode() != this.hashCode() || rope.length != this.length)
      if (rope.length != this.length)
        return false;
    
      for (int j = 0; j<this.length; ++j){
        int a = this.charCodeAt(j);
        int b = rope.charCodeAt(j);
        
        if (a != b)
          return false;
      }
      return true;
    }
    return false;
  }
  
  int indexOf(final String ch) {
    int index = -1;

    
// TODO:   for (final char c: this) {
//      ++index;
//      if (c == ch)
//        return index;
//    }
    return -1;

  }
  
  Rope insert(final int dstOffset, final String s) {
    final Rope r = (s == null) ? build("null") : build(s);
    
    if (dstOffset == 0)
      return r.appendRope(this);
    else if (dstOffset == this.length)
      return this.appendRope(r);
    else if (dstOffset < 0 || dstOffset > this.length)
      throw new IndexOutOfRangeException(this.length);
    return this.subSequence(0, dstOffset).appendRope(r).appendRope(this.subSequence(dstOffset, this.length));
  }
  
  //TODO: Iterator<Character> iterator() { return this.iterator(0); }
  
  int compareTo(String sequence) {
    int compareTill = Math.min(sequence.length, length);
    
    List<int> cc = sequence.charCodes();
    for (int j=0; j<compareTill; ++j) {
      int x = this.charCodeAt(j);
      int y = cc[j];
      if (x != y)
        return x - y;
    }
    return length - sequence.length;
    
//TODO:    Iterator<Character> i = iterator();
//    for (int j=0; j<compareTill; ++j) {
//      char x = i.next();
//      char y = sequence.charAt(j);
//      if (x != y)
//        return x - y;
//    }
//    return length() - sequence.length();

  }
  
  String toString() {
// TODO:   StringWriter out = new StringWriter(length());
//    try {
//      write(out);
//      out.close();
//    } catch (IOException e) {
//      throw new RuntimeException(e);
//    }
//    return out.toString();
//  
  }
}

// vim:foldmethod=marker sw=2 sts=2 ts=2 tw=0 et ai nowrap
