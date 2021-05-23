
//  const PrivateKeyProvider = require("truffle-hdwallet-provider");
//  const localPrivateKeyProvider = new PrivateKeyProvider(privateKey, "http://127.0.0.1:8545");
//  const privateKey = "c87509a1c067bbde78beb793e6fa76530b6382a4c0241e5e4a9ec0a0f44dc0d3";

module.exports = {
  
  contracts_build_directory: "./frontend/src/abis",
  networks: {
    development: {
     host: "127.0.0.1",     // Localhost (default: none)
     port: 8545,            // Standard Ethereum port (default: none)
     network_id: "*",       // Any network (default: none)
    },
  
  },

  // Configure your compilers
  compilers: {
    solc: {
      version: "0.8.0",    // Fetch exact version from solc-bin (default: truffle's version)
    },
  },
};
