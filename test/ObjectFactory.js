var ObjectFactory = artifacts.require("./ObjectFactory.sol");

contract("objectFactory", async(accounts) => {
  let instance = await ObjectFactory.deployed();
  it('should create an object and returns the right bet amount and deposit amount', async() => {
    await instance.createObject("X", 10, 2);
    let deposit = await instance.objectFund.call(0);
    let betAmount = await instance.objectBetAmount.call(0);
    assert.equal(deposit, 5);
    assert.equal(betAmount, 1);
  });
});
