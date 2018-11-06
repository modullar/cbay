pragma solidity ^0.4.24;

import "./SafeMath.sol";
// Needs to be Ownable for later.

contract ObjectFactory {

  uint depositPercent = 10;

  event newObject(uint objectId, string name, uint _totalCostInEther, uint _numBettors);

  enum Status {inactive, active, processed}

  struct Object{
    string name;
    Status status;
    uint totalCostInEther;
    uint numBettors;
    mapping (uint => address) bettors;
  }

  Object[] public objects;

  mapping (uint => address) public objectToOwner;
  mapping (address => uint) ownerObjectsCount;
  mapping (uint => uint) public betToObject;

  function createObject(string _name, uint _totalCostInEther, uint _numBettors) public payable returns(bool success) {
    //require(msg.value == ((_totalCostInEther * 5)/100));
    _createObject(_name, _totalCostInEther, _numBettors);
    return true;
  }

  function objectFund(uint _id) public view returns(uint){
    return(objects[_id].totalCostInEther / objects[_id].numBettors);
  }

  function objectBetAmount(uint _id) view public returns(uint){
    return(objects[_id].totalCostInEther * depositPercent / 100);
  }

  function _createObject(string _name, uint _totalCostInEther, uint _numBettors) internal {
    uint id = objects.push(Object(_name, Status.inactive, _totalCostInEther, _numBettors));
    objectToOwner[id] = msg.sender;
    ownerObjectsCount[msg.sender]++;
    emit newObject(id, _name, _totalCostInEther, _numBettors);
  }

  function objectsCount() external view returns(uint){
    return objects.length;
  }

  function getObject(uint _id) public view returns(string, Status, uint, uint) {
    Object memory o = objects[_id];
    return(o.name, o.status, o.numBettors, o.totalCostInEther);
  }

}
