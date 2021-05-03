const HDWalletProvider = require("truffle-hdwallet-provider");

module.exports = {
  contracts_directory: "./contracts/",
  networks: {
    development: {
      host: "localhost",
      port: 7545,
      gas: 5000000,
      network_id: "*", // Match any network id
    },
  },
  compilers: {
    solc: {
      version: "^0.8.4"
    },
  },
};
