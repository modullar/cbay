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
    Assert.equal(objectFactory.createObject('sofa', 0.1 ether, 10), true, 'A new object is created');
    Assert.equal(objectFactory.objectsCount(), 1, 'A new object is created');
    string memory name;
    ObjectFactory.Status status;
    uint numBettors;
    uint totalCostInEther;
    (name, status, numBettors, totalCostInEther) = (objectFactory.getObject(0));
    Assert.equal(keccak256(abi.encode(name)), keccak256(abi.encode('sofa')), 'should have the same name');
    Assert.equal(uint(status), uint(ObjectFactory.Status.inactive), 'should have the status inactive');
    Assert.equal(uint(numBettors), uint(10), 'should be 10 bettors');
    Assert.equal(uint(totalCostInEther), uint(0.1 ether), 'should have 0.1 total cost for ether');
  }

}
