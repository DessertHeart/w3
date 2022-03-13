
const hre = require("hardhat");

async function main() {

  // 部署
  const [deployer, addrTest1, addrTest2] = await ethers.getSigners();

  console.log(
    "Deploying contracts with the account:",
    await deployer.getAddress()
  );
  
  //console.log("Account balance:", (await deployer.getBalance()).toString());

  const Vault = await ethers.getContractFactory("Vault");
  const vault = await Vault.deploy();

  await vault.deployed();
  console.log("Vault address:", vault.address);

  // 转账50token
  await vault.mint(await deployer.getAddress(), 50);
  console.log("deployer balance:", (await vault.balanceOf(deployer.getAddress())).toString());
  console.log("addrTest2 balance:", (await vault.balanceOf(addrTest2.getAddress())).toString());

  await vault.approve(await deployer.getAddress(), 50);
  await vault.transferFrom(await deployer.getAddress(), await addrTest2.getAddress(), 50);
  console.log("deployer balance:", (await vault.balanceOf(deployer.getAddress())).toString());
  console.log("addrTest2 balance:", (await vault.balanceOf(addrTest2.getAddress())).toString());

}

main()
  .then(() => process.exit(0))
  .catch((error) => {
    console.error(error);
    process.exit(1);
  });
