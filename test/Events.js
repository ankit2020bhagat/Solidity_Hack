const { ethers } = require("hardhat");
const hre =require("hardhat");

describe("Event",function(){
    it(" Events Contract Deployment",async function(){
        const deployContract=await ethers.getContractFactory("Events");

        const Contract= await deployContract.deploy();
        await Contract.deployed();
        console.log("Contract Address",Contract.address);
  
    })
})