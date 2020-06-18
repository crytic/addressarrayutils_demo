pragma solidity 0.4.24;

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
      addrs2.push(1);      
    }
  }

  function set_addr(address newa) public {
    everSet = true;
    a = newa;
  }

  function crytic_hasDuplicate() public view returns (bool) {
    if (!everSet) {
      return true;
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
    return hasDup == AddressArrayUtils.hasDuplicate(addrs1);
  }

  function crytic_remove() public view returns (bool) {
    if (!everSet) {
      return true;
    }
    if (!AddressArrayUtils.contains(addrs1, a)) {
      return true;
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
      return false;
    }
    uint256 acountNew = 0;
    for (i = 0; i < removed.length; i++) {
      if (removed[i] == a) {
        acountNew++;
      }
    }
    if (acountNew != (acount-1)) {
      return false;
    }
    if (!AddressArrayUtils.hasDuplicate(addrs1)) {
      if (AddressArrayUtils.contains(removed, a)) {
        return false;
      }
    }
    return true;
  }

  function crytic_revert_remove() public view returns (bool) {
    if (!everSet) {
      revert();
    }
    if (AddressArrayUtils.contains(addrs1, a)) {
      revert();
    }
    AddressArrayUtils.remove(addrs1, a);
  }
}
