const ScoreBallot = artifacts.require("ScoreBallot");

module.exports = function(deployer) {
    deployer.deploy(ScoreBallot);
};