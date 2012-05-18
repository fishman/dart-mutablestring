// join strings
// create a substring for substringropes
// benchmark you run  it per seconds. so loop see how many iterations per 2 seconds

MutableString build(final sequence){
  if (sequence is MutableString)
    return sequence;
  return new FlatRope(sequence);
}

/**
 * MutableString utilities
 * length of FIBONACCI list = 93;
 * when the depth of a rope becomes 96 we start rebalance the tree
 */
final FIBONACCI = const [ 0, 1, 1, 2, 3, 5, 8, 13, 21, 34, 55, 89, 144, 233, 377, 610, 987, 1597, 2584, 4181, 6765, 10946, 17711, 28657, 46368, 75025, 121393, 196418, 317811, 514229, 832040, 1346269, 2178309, 3524578, 5702887, 9227465, 14930352, 24157817, 39088169, 63245986, 102334155, 165580141, 267914296, 433494437, 701408733, 1134903170, 1836311903, 2971215073, 4807526976, 7778742049, 12586269025, 20365011074, 32951280099, 53316291173, 86267571272, 139583862445, 225851433717, 365435296162, 591286729879, 956722026041, 1548008755920, 2504730781961, 4052739537881, 6557470319842, 10610209857723, 17167680177565, 27777890035288, 44945570212853, 72723460248141, 117669030460994, 190392490709135, 308061521170129, 498454011879264, 806515533049393, 1304969544928657, 2111485077978050, 3416454622906707, 5527939700884757, 8944394323791464, 14472334024676221, 23416728348467685, 37889062373143906, 61305790721611591, 99194853094755497, 160500643816367088, 259695496911122585, 420196140727489673, 679891637638612258, 1100087778366101931, 1779979416004714189, 2880067194370816120, 4660046610375530309, 7540113804746346429];
final int max_depth = 96;
final String spaces = "                                                                                                    ";


MutableString Rebalance(final MutableString r) {
  // TODO:
  // List<MutableString> ropes = new MutableString[FIBONACCI.length];
  
  return r;
}

/* TODO: needs work
MutableString Rebalance(final MutableString r) {
  List<MutableString> ropes = new MutableString[FIBONACCI.length];

  final ArrayDeque<MutableString> toExamine = new ArrayDeque<MutableString>();
  // begin a depth first loop.
  toExamine.add(r);
  while (toExamine.size() > 0) {
    final MutableString x = toExamine.pop();
    if (x instanceof ConcatenationRope) {
      toExamine.push(((ConcatenationRope) x).getRight());
      toExamine.push(((ConcatenationRope) x).getLeft());
      continue;
    }
    if (x instanceof FlatRope || x instanceof SubstringRope) {
      final int l = x.length();
      int pos;
      boolean lowerSlotsEmpty=true;
      for (pos=2; pos<FIBONACCI.length-1; ++pos) {
        if (ropes[pos] != null)
          lowerSlotsEmpty = false;
        if (FIBONACCI[pos] <= l && l < FIBONACCI[pos+1])  // l is in [F(pos), F(pos+1))
          break;
      }
      if (lowerSlotsEmpty) {
        ropes[pos] = x;
      } else {
        MutableString rebalanced = null;
        for (int j=2; j<=pos; ++j) {
          if (ropes[j] != null) {
            if (rebalanced == null)
              rebalanced=ropes[j];
            else
              rebalanced=ropes[j].append(rebalanced);
            ropes[j] = null;
          }
        }
        rebalanced = rebalanced.append(x);
        for (int j=pos; j<FIBONACCI.length-1; ++j) {
          if (ropes[j] != null) {
            rebalanced = ropes[j].append(rebalanced);
            ropes[j] = null;
          }
          if (FIBONACCI[j] <= rebalanced.length() && rebalanced.length() < FIBONACCI[j+1]) {
            ropes[j] = rebalanced;
            break;
          }
        }
      }
    }
  }

  // perform the final concatenation
  MutableString result = null;
  for (int j=2; j<FIBONACCI.length; ++j) {
    if (ropes[j] != null) {
      result = (result == null) ? ropes[j]: ropes[j].append(result);
    }
  }
  return result;
}
*/

MutableString concatenate(final MutableString left, final MutableString right) {
  // TODO:
  if (left is FlatRope && right is FlatRope) {
    final FlatRope fLeft = left;
    final FlatRope fRight = right;
    // TODO: we need to check how big a string should be for it to be feasible
    // to be turned into a rope
    if (fLeft.length + fRight.length < 16) {
      return new FlatRope(fLeft.toString() + fRight.toString());
    }
  }
  if (left is ConcatenationRope && right is FlatRope) {
    final ConcatenationRope cLeft = left;
    final FlatRope fRight = right;

    if (cLeft.right is FlatRope) {
      final FlatRope fLeftRight = cLeft.right;
      if (fLeftRight.length + fRight.length < 16) {
        return autoRebalance(new ConcatenationRope(cLeft.left, new FlatRope(fLeftRight.toString() + fRight.toString())));
      }
    }
  }
  if (left is FlatRope && right is ConcatenationRope) {
    final FlatRope fLeft = left;
    final ConcatenationRope cRight  = right;

    if (cRight.left is FlatRope) {
      final FlatRope cRightLeft = cRight.left;
      if (fLeft.length + cRightLeft.length < 16) {
        return autoRebalance(new ConcatenationRope(new FlatRope(fLeft.toString() + cRightLeft.toString()), cRight.right));
      }
    }
  }
  return autoRebalance(new ConcatenationRope(left, right));

}

int Depth(final MutableString r) {
  if (r is MutableString) {
    return r.depth();
  } else {
    throw new IllegalArgumentException("Bad rope");
  }
}
  
bool isBalanced(final MutableString r) {
  final int dep = Depth(r);
  if (dep >= FIBONACCI.length - 2)
    return false;
  return FIBONACCI[dep +2] <= r.length;
}

MutableString autoRebalance(final MutableString r) {
  if (r is MutableString && r.depth() > max_depth) {
    return Rebalance(r);
  } else {
    return r;
  }
}

visualize(final MutableString r) {
  visualizeDepth(r, 0);
}

visualizeDepth(final MutableString r, final int depth) {
  if (r is FlatRope) {
    // TODO:
    print("hello");
  }
  if (r is SubstringRope) {
    // TODO:
    print("hello");
  }
  if (r is ConcatenationRope) {
    // TODO:
    print("hello");
  }
}

interface MutableString {// extends Iterable<Rope> {
  MutableString append(String c);
  
  MutableString appendSubstr(String c, int start, int end);
  
  MutableString appendRope(Rope r);
  
  MutableString delete(int start, int end);

  int indexOf(String ch);
  
  MutableString insert(int dstOffset, String str);
  
  int get length();
  
  int charCodeAt(int index);
  // TODO: Iterator<String> iterator(int start)
  
  int depth();
  
  int hashCode();
  
  MutableString rebalance();
  
  // TODO: implement charcodes();
//  List<int> charCodes();
  
  // TODO: write(Writer out)
  
  MutableString subSequence(int start, int end);
  
  // TODO: matcher
}

// vim:foldmethod=marker sw=2 sts=2 ts=2 tw=0 et ai nowrap
