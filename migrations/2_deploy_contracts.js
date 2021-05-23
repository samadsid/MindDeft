const Liquidity = artifacts.require("Liquidity");
const Staking = artifacts.require("Staking");
const Deposit = artifacts.require("Deposit");

module.exports = async function (deployer) {
  await deployer.deploy(Liquidity);
  let liquidityContractInstance = await Liquidity.deployed()
  await deployer.deploy(Staking);
  let stakingContractInstance = await Staking.deployed()
  await deployer.deploy(Deposit,liquidityContractInstance.address,stakingContractInstance.address)
};
