const { Contract } = require("ethers");
const hre = require("hardhat");

describe("dynamicSizeArray",function(){
    it("Contract deployment ",async function(){
        const deployContract=await hre.ethers.getContractFactory("dynamicSizeArray");
        await Contract= await deployContract.deployed();

        await Contract.deployed();

        console.log("Dynamic Array Contract address",Contract.address);
    })
})