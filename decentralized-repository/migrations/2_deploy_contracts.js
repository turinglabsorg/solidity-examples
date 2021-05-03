const dRepo = artifacts.require("./dRepo.sol");

module.exports = async (deployer) => {
  await deployer.deploy(dRepo, { gas: 5000000 });
};
