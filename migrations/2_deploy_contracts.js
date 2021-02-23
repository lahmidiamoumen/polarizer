const Election = artifacts.require("Election");

module.exports = function(deployer) {
  deployer.deploy(Election,"Moumen",90,"Boutef","Madjid");
};
