pragma solidity ^0.4.24;

import "./ObjectFactory.sol";


contract ObjectHelper is ObjectFactory{

  modifier onlyOwnerOf(uint _objectId) {
    require(msg.sender == objectToOwner[_objectId]);
    _;
  }





}
