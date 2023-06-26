const VotingRecords = artifacts.require("VotingRecords");

module.exports = function(deployer) {
  deployer.deploy(VotingRecords);
};
