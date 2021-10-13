const SupplyChainFactory = artifacts.require("SupplyChainFactory");

module.exports = function (deployer) {
  deployer.deploy( SupplyChainFactory );
};