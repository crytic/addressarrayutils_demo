pragma solidity 0.4.25;

import "./AddressArrayUtils.sol"; 

contract TEST {

  address [] addrs1;
  address [] addrs2;
  address a;

  bool everSet = false;
  
  function push_it_1() public {
    if (everSet) {
      addrs1.push(a);
    }
  }

  function push_it_2() public {
    if (everSet) {
      addrs2.push(a);
    }
  }
    
  function push_it_both() public {
    if (everSet) {
      addrs1.push(a);
      addrs2.push(a);      
    }
  }

  function set_addr(address newa) public {
    everSet = true;
    a = newa;
  }

  function test_find() public {
    if (!everSet) {
      return;
    }
    uint256 i;
    uint256 j;
    bool b;
    (i, b) = AddressArrayUtils.indexOf(addrs1, a);
    if (b) {
      if (addrs1[i] != a) {
	assert(false);
      }
      for (j = 0; j < i; j++) {
	if (addrs1[j] == a) {
	  assert(false);
	}
      }
      if (!AddressArrayUtils.contains(addrs1, a)) {
	assert(false);
      }
      (i, b) = AddressArrayUtils.indexOfFromEnd(addrs1, a);
      if (!b) {
	assert(false);
      }
      if (addrs1[i-1] != a) {
	assert(false);
      }      
      for (j = (addrs1.length-1); j >= i; j--) {
	if (addrs1[j] == a) {
	  assert(false);
	}
      }
    } else {
      for (j = 0; j < addrs1.length; j++) {
	if (addrs1[j] == a) {
	  assert(false);
	}
      }
      if (AddressArrayUtils.contains(addrs1, a)) {
	assert(false);
      }
      (i, b) = AddressArrayUtils.indexOfFromEnd(addrs1, a);
      if (b) {
	assert(false);
      }
    }
    return;
  }

  function test_append() public {
    if (!everSet) {
      return;
    }    
    address [] memory addrs1PlusA = AddressArrayUtils.append(addrs1, a);
    uint256 i;
    uint256 j;
    bool b1;
    bool b2;
    if (AddressArrayUtils.isEqual(addrs1, addrs1PlusA)) {
      assert(false);
    }
    (i, b1) = AddressArrayUtils.indexOfFromEnd(addrs1PlusA, a);
    if (!b1) {
      assert(false);
    }
    if (i != (addrs1PlusA.length)) {
      assert(false);
    }
    if (addrs1PlusA[i-1] != a) {
      assert(false);
    }
    (j, b2) = AddressArrayUtils.indexOf(addrs1PlusA, a);
    if (!b2) {
      assert(false);
    }
    if (addrs1PlusA[j] != a) {
      assert(false);
    }
    if (AddressArrayUtils.contains(addrs1, a)) {
      if (j >= (i-1)) {
	assert(false);
      }
      if (!AddressArrayUtils.hasDuplicate(addrs1PlusA)) {
	assert(false);
      }
    } else {
      if (j != (i-1)) {
	assert(false);
      }
    }
    return;
  }

  function test_extend() public {
    if (!everSet) {
      return;
    }    
    address [] memory addrs1PlusAddrs2 = AddressArrayUtils.extend(addrs1, addrs2);
    uint256 i;
    for (i = 0; i < addrs1.length; i++) {
      if (!AddressArrayUtils.contains(addrs1PlusAddrs2, addrs1[i])) {
	assert(false);
      }
    }
    for (i = 0; i < addrs2.length; i++) {
      if (!AddressArrayUtils.contains(addrs1PlusAddrs2, addrs2[i])) {
	assert(false);
      }
    }
    if (!AddressArrayUtils.contains(addrs1, a) && !AddressArrayUtils.contains(addrs2, a)) {
      if (AddressArrayUtils.contains(addrs1PlusAddrs2, a)) {
	assert(false);
      }
    }
    return;
  }

  function test_sExtend() public {
    if (!everSet) {
      return;
    }
    bool notInEither = !AddressArrayUtils.contains(addrs1, a) && !AddressArrayUtils.contains(addrs2, a);
    uint256 addrs1Length = addrs1.length;
    uint256 addrs2Length = addrs2.length;    
    AddressArrayUtils.sExtend(addrs1, addrs2);
    uint256 i;
    for (i = 0; i < addrs2.length; i++) {
      if (!AddressArrayUtils.contains(addrs1, addrs2[i])) {
	assert(false);
      }
    }
    if (addrs1.length != (addrs1Length + addrs2Length)) {
      assert(false);
    }
    if (notInEither && AddressArrayUtils.contains(addrs1, a)) {
      assert(false);
    }
    return;
  }

  function test_hasDuplicate() public {
    if (!everSet) {
      return;
    }
    bool hasDup = false;
    uint i1;
    uint i2;
    bool b;
    for (uint i = 0; i < addrs1.length; i++) {
      (i1, b) = AddressArrayUtils.indexOf(addrs1, addrs1[i]);
      (i2, b) = AddressArrayUtils.indexOfFromEnd(addrs1, addrs1[i]);
      if (i1 != (i2-1)) {
	hasDup = true;
      }
    }
    assert(hasDup == AddressArrayUtils.hasDuplicate(addrs1));
  }
  
  function test_isEqual() public {
    if (!everSet) {
      return;
    }    
    uint256 length1 = addrs1.length;
    uint256 length2 = addrs2.length;
    bool areEqual = AddressArrayUtils.isEqual(addrs1, addrs2);
    if (length1 != length2) {
      assert(!areEqual);
      return;
    }
    for (uint i = 0; i < length1; i++) {
      if (addrs1[i] != addrs2[i]) {
	assert(!areEqual);
	return;
      }
    }
    assert(areEqual);
  }
  
  function test_sReverse() public {
    if (!everSet) {
      return;
    }    
    uint256 length = addrs1.length;
    address a0;
    address a1;
    if (length > 0) {
      a0 = addrs1[0];
      a1 = addrs1[length-1];
    }
    AddressArrayUtils.sReverse(addrs1);
    if (addrs1.length != length) {
      assert(false);
    }
    if (length > 0) {
      if (a0 != addrs1[length-1]) {
	assert(false);
      }
      if (a1 != addrs1[0]) {
	assert(false);
      }
    }
    return;
  }

  function ourEqual(address[] memory A, address[] memory B) internal pure returns (bool) {
    uint256 i;
    uint256 j;
    bool found;
    for (i = 0; i < A.length; i++) {
      found = false;
      for (j = 0; j < B.length; j++) {
	if (A[i] == B[j]) {
	  found = true;
	  break;
	}
      }
      if (!found) {
	return false;
      }
    }
    for (i = 0; i < B.length; i++) {
      found = false;
      for (j = 0; j < A.length; j++) {
	if (A[j] == B[i]) {
	  found = true;
	  break;
	}
      }
      if (!found) {
	return false;
      }
    }
    return true;    
  }

  function test_diff() public {
    if (!everSet) {
      return;
    }
    address [] memory empty = new address[](0);
    address [] memory diff1 = AddressArrayUtils.difference(addrs1, addrs2);
    address [] memory diff2 = AddressArrayUtils.difference(addrs2, addrs1);
    if (!ourEqual(addrs1, addrs2) == ourEqual(diff1, diff2)) {
      assert(false);
    }
    if (!ourEqual(AddressArrayUtils.difference(addrs1, addrs1), empty)) {
      assert(false);
    }
    return;
  }

  function test_union() public {
    if (!everSet) {
      return;
    }
    address [] memory empty = new address[](0);
    address [] memory union1 = AddressArrayUtils.union(addrs1, addrs2);
    address [] memory union2 = AddressArrayUtils.union(addrs2, addrs1);
    address [] memory unionB1 = AddressArrayUtils.unionB(addrs1, addrs2);
    address [] memory unionB2 = AddressArrayUtils.unionB(addrs2, addrs1);    
    if (!ourEqual(union1, union2)) {
      assert(false);
    }
    if (!AddressArrayUtils.hasDuplicate(addrs1) && !AddressArrayUtils.hasDuplicate(addrs2)) {
      if (!ourEqual(unionB1, unionB2)) {
	assert(false);
      }
    }
    if (!ourEqual(AddressArrayUtils.union(addrs1, empty), addrs1)) {
      assert(false);
    }    
    return;
  }

  function test_intersect() public {
    if (!everSet) {
      return;
    }
    address [] memory empty = new address[](0);
    address [] memory intersect1 = AddressArrayUtils.intersect(addrs1, addrs2);
    address [] memory intersect2 = AddressArrayUtils.intersect(addrs2, addrs1);
    if (!ourEqual(intersect1, intersect2)) {
      assert(false);
    }
    if (!ourEqual(AddressArrayUtils.intersect(addrs1, empty), empty)) {
      assert(false);
    }
    return;
  }

  function test_remove() public {
    if (!everSet) {
      return;
    }    
    if (!AddressArrayUtils.contains(addrs1, a)) {
      return;
    }
    uint256 acount = 0;
    uint256 i;
    for (i = 0; i < addrs1.length; i++) {
      if (addrs1[i] == a) {
	acount++;
      }
    }
    address [] memory removed = AddressArrayUtils.remove(addrs1, a);
    if (removed.length != (addrs1.length-1)) {
      assert(false);
    }
    uint256 acountNew = 0;
    for (i = 0; i < removed.length; i++) {
      if (removed[i] == a) {
	acountNew++;
      }
    }
    if (acountNew != (acount-1)) {
      assert(false);
    }
    if (!AddressArrayUtils.hasDuplicate(addrs1)) {
      if (AddressArrayUtils.contains(removed, a)) {
	assert(false);
      }
    }
    return;
  }

  function test_revert_remove() public {
    if (!everSet) {
      revert();
    }
    if (AddressArrayUtils.contains(addrs1, a)) {
      revert();
    }
    AddressArrayUtils.remove(addrs1, a);
  }

  function test_pop() public {
    if (!everSet) {
      return;
    }    
    if (!AddressArrayUtils.contains(addrs1, a)) {
      return;
    }
    uint256 aIndex;
    bool aFound;
    (aIndex, aFound) = AddressArrayUtils.indexOf(addrs1, a);
    uint256 acount = 0;
    uint256 i;
    for (i = 0; i < addrs1.length; i++) {
      if (addrs1[i] == a) {
	acount++;
      }
    }
    address [] memory removed;
    address apop;
    (removed, apop) = AddressArrayUtils.pop(addrs1, aIndex);
    if (apop != a) {
      assert(false);
    }
    if (removed.length != (addrs1.length-1)) {
      assert(false);
    }
    uint256 acountNew = 0;
    for (i = 0; i < removed.length; i++) {
      if (removed[i] == a) {
	acountNew++;
      }
    }
    if (acountNew != (acount-1)) {
      assert(false);
    }
    if (!AddressArrayUtils.hasDuplicate(addrs1)) {
      if (AddressArrayUtils.contains(removed, a)) {
	assert(false);
      }
    }
    return;
  }

  function test_sRemoveCheap() public {
    if (!everSet) {
      return;
    }    
    if (!AddressArrayUtils.contains(addrs1, a)) {
      return;
    }
    uint256 acount = 0;
    uint256 i;
    for (i = 0; i < addrs1.length; i++) {
      if (addrs1[i] == a) {
	acount++;
      }
    }
    uint256 oldLength = addrs1.length;
    bool anyDuplicates = AddressArrayUtils.hasDuplicate(addrs1);
    AddressArrayUtils.sRemoveCheap(addrs1, a);
    if (addrs1.length != (oldLength-1)) {
      assert(false);
    }
    uint256 acountNew = 0;
    for (i = 0; i < addrs1.length; i++) {
      if (addrs1[i] == a) {
	acountNew++;
      }
    }
    if (acountNew != (acount-1)) {
      assert(false);
    }
    if (!anyDuplicates) {
      if (AddressArrayUtils.contains(addrs1, a)) {
	assert(false);
      }
    }
    return;
  }

  function test_revert_sRemoveCheap() public {
    if (!everSet) {
      revert();
    }
    if (AddressArrayUtils.contains(addrs1, a)) {
      revert();
    }
    AddressArrayUtils.sRemoveCheap(addrs1, a);
  }

  function test_sPop() public {
    if (!everSet) {
      return;
    }    
    if (!AddressArrayUtils.contains(addrs1, a)) {
      return;
    }
    uint256 aIndex;
    bool aFound;
    (aIndex, aFound) = AddressArrayUtils.indexOf(addrs1, a);
    uint256 acount = 0;
    uint256 i;
    for (i = 0; i < addrs1.length; i++) {
      if (addrs1[i] == a) {
	acount++;
      }
    }    
    uint256 oldLength = addrs1.length;
    bool anyDuplicates = AddressArrayUtils.hasDuplicate(addrs1);
    address apop = AddressArrayUtils.sPop(addrs1, aIndex);
    if (apop != a) {
      assert(false);
    }
    if (addrs1.length != (oldLength-1)) {
      assert(false);
    }
    uint256 acountNew = 0;
    for (i = 0; i < addrs1.length; i++) {
      if (addrs1[i] == a) {
	acountNew++;
      }
    }
    if (acountNew != (acount-1)) {
      assert(false);
    }
    if (!anyDuplicates) {
      if (AddressArrayUtils.contains(addrs1, a)) {
	assert(false);
      }
    }
    return;
  }

  function test_revert_sPop() public {
    if (!everSet) {
      revert();
    }
    uint256 index = addrs1.length;
    AddressArrayUtils.sPop(addrs1, index);
  }

  function test_sPopCheap() public {
    if (!everSet) {
      return;
    }    
    if (!AddressArrayUtils.contains(addrs1, a)) {
      return;
    }
    uint256 aIndex;
    bool aFound;
    (aIndex, aFound) = AddressArrayUtils.indexOf(addrs1, a);
    uint256 acount = 0;
    uint256 i;
    for (i = 0; i < addrs1.length; i++) {
      if (addrs1[i] == a) {
	acount++;
      }
    }    
    uint256 oldLength = addrs1.length;
    bool anyDuplicates = AddressArrayUtils.hasDuplicate(addrs1);
    address apop = AddressArrayUtils.sPopCheap(addrs1, aIndex);
    if (apop != a) {
      assert(false);
    }
    if (addrs1.length != (oldLength-1)) {
      assert(false);
    }
    uint256 acountNew = 0;
    for (i = 0; i < addrs1.length; i++) {
      if (addrs1[i] == a) {
	acountNew++;
      }
    }
    if (acountNew != (acount-1)) {
      assert(false);
    }
    if (!anyDuplicates) {
      if (AddressArrayUtils.contains(addrs1, a)) {
	assert(false);
      }
    }
    return;
  }

  function test_revert_sPopCheap() public {
    if (!everSet) {
      revert();
    }
    uint256 index = addrs1.length;
    AddressArrayUtils.sPopCheap(addrs1, index);
  }
  
  function test_argGet() public {
    if (!everSet) {
      return;
    }
    if (addrs1.length < 1) {
      return;
    }
    bool found;
    uint256 index;
    uint256 i;
    uint256[] memory indexArray = new uint256[](addrs2.length);
    for (i = 0; i < indexArray.length; i++) {
      (index, found) = AddressArrayUtils.indexOf(addrs1, addrs2[i]);
      if (found) {
	indexArray[i] = index;
      } else {
	indexArray[i] = 0;
      }
    }
    address[] memory argGetResult = AddressArrayUtils.argGet(addrs1, indexArray);
    for (i = 0; i < argGetResult.length; i++) {
      if (argGetResult[i] != addrs1[indexArray[i]]) {
	assert(false);
      }
    }
    return;
  }
  
}
