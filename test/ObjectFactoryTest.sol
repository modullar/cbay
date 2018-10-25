pragma solidity ^0.4.24;


import "truffle/Assert.sol";
import "truffle/DeployedAddresses.sol";
import "../contracts/ObjectFactory.sol";

contract ObjectFactoryTest {

  ObjectFactory objectFactory;

  function beforeEach() public {
    objectFactory = new ObjectFactory();
  }

  function testCreateObject() public {
    Assert.equal(objectFactory.createObject('sofa', 10, 100), true, 'A new object is created');
    Assert.equal(objectFactory.objectsCount(), 1, 'A new object is created');
    string memory name;
    ObjectFactory.Status status;
    uint64 bettorsCount;
    uint totalCost;
    (name, status, bettorsCount, totalCost) = (objectFactory.getObject(0));
    Assert.equal(keccak256(abi.encode(name)), keccak256(abi.encode('sofa')), 'should have the same name');
    Assert.equal(uint(status), uint(ObjectFactory.Status.inactive), 'should have the status inactive');
    Assert.equal(uint(bettorsCount), uint(10), 'should be 10 bettors');
    Assert.equal(uint(totalCost), uint(100), 'should have 100 total costs');
//    Assert.equal(objectFactory.ownerObjectsCount[owner], 1, 'the owner has 1 object');
  }

}
