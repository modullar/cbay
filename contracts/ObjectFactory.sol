pragma solidity ^0.4.24;


contract ObjectFactory {

  event newObject(uint objectId, string name, uint64 _bettorsCount,
                  uint _totalCost);

  struct Object{
    string name;
    uint8 status;
    uint64 bettorsCount;
    uint totalCost;
  }

  Object[] public objects;

  mapping (uint => address) public objectToOwner;
  mapping (address => uint) ownerObjectsCount;
//  mapping (uint => string) statusName;


  function _createObject(string _name, uint64 _bettorsCount, uint _totalCost) internal {
    uint id = objects.push(Object(_name, 0, _bettorsCount, _totalCost));
    objectToOwner[id] = msg.sender;
    ownerObjectsCount[msg.sender]++;
    emit newObject(id, _name, _bettorsCount, _totalCost);
  }

  function objectsCount() external view returns(uint){
    return objects.length;
  }

  function getObject(uint id) external view returns(string, uint8, uint64, uint) {
    Object memory o = objects[id];
    return(o.name, o.status, o.bettorsCount, o.totalCost);
  }

  function createObject(string _name, uint64 _bettorsCount, uint _totalCost) public returns(bool success) {
    _createObject(_name, _bettorsCount, _totalCost);
    return true;
  }
}