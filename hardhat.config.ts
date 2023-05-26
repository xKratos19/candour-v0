import { HardhatUserConfig } from "hardhat/config";
import "@nomicfoundation/hardhat-toolbox";
import { network } from "hardhat";
import "@nomiclabs/hardhat-etherscan";
import "hardhat-deploy";

const config: HardhatUserConfig = {
  solidity: "0.8.17",
};

module.exports = {
  solidity: "0.8.18",
  networks: {
    Testnet: {
      live: true,
      url: "https://rpc.testnet.lukso.network/",
      chainId: 4201,
      accounts: ["48cea461cb2f60e6b81182c2a9137b9720f3d1c90a975c27fb3421b80cc3c2bb"] // your private key here
    },
  },
  etherscan: {
    // no API is required to verify contracts
    // via the Blockscout instance of L16 network
    apiKey: "no-api-key-needed",
    customChains: [
      {
        network: "luksoL16",
        chainId: 2828,
        urls: {
          apiURL: "https://explorer.execution.l16.lukso.network/api",
          browserURL: "https://explorer.execution.l16.lukso.network/",
        },
      },
    ],
  },
};


export default config;
