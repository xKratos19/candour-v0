const { ethers, upgrades } = require("hardhat");

async function main() {
  // Deploying Candour contract
  const Candour = await ethers.getContractFactory("Candour");
  console.log("Deploying Candour contract...");
  const candour = await Candour.deploy("Test","CA")
  await candour.deployed();
  console.log("Candour contract deployed:", candour.address);
}

main()
  .then(() => process.exit(0))
  .catch((error) => {
    console.error(error);
    process.exit(1);
  });
