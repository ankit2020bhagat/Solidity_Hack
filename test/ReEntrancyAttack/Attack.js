const { ethers } = require("hardhat");

describe("Attack ",function(){
   
    let deployContract,addresses;
    it("Contract deployment",async function(){
    [...addresses]= await ethers.getSigners();
      const Attack_Contract = await ethers.getContractFactory("Attack");
      deployContract = await Attack_Contract.deploy("0x5FbDB2315678afecb367f032d93F642f64180aa3");
      await deployContract.deployed();
      console.log("Contract Address :",deployContract.address);
    })

    it("Calling Attack function",async function(){
        let Amount= ethers.utils.parseEther("1");
        const txn_attack = await deployContract.connect(addresses[4]).attack({value:Amount,gasLimit :6721975,gasPrice: 20000000000});
        await txn_attack.wait();
        console.log("Contract Balance :",await deployContract.getBalance());
    })
  })