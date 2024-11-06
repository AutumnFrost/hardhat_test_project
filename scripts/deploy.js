// import ethers.js
// creat main function
// execute main function 执行

// const { ethers } = require("hardhat");

// async function main() {
//   const fundMeFactory = await ethers.getContractFactory("Voting");
//   console.log("bbbbbbbbbbbbbbbbbbbbbb")
//   const fundMe = await fundMeFactory.deploy();
//   await fundMe.waitForDeployment();
//   console.log("contract has been deployed successfully", fundMe.target);
// }

// main().then().catch((error) => {
//   console.error(error);
//   process.exit(1);
// });

const hre = require("hardhat");

async function main() {
    const add = await hre.ethers.deployContract("Voting");
    await add.waitForDeployment();
    console.log( `Add deployed to ${add.target}`);
}

main().catch((error) => {
    console.error(error);
    process.exitCode = 1;
});