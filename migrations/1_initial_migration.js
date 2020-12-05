const Migrations = artifacts.require("Migrations");
const Hasher = artifacts.require("Hasher")


module.exports = function (deployer) {
  deployer.deploy(Migrations);
  deployer.deploy(Hasher);
};
