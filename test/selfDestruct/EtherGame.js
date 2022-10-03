const { ethers } = require("hardhat");

describe.only("Ether Game ", function () {
    let deployContract, addresses;
    it("Contract deployment ", async function () {
        [...addresses] = await ethers.getSigners();
        const EtherGame = await ethers.getContractFactory("EtherGame");
        deployContract = await EtherGame.deploy();
        await deployContract.deployed();
        console.log("contract Address :", deployContract.address);
    })

    it("Calling deposit function ", async function () {
        let Amount = ethers.utils.parseEther("1");
        const txn_deposit = await deployContract.connect(addresses[0]).deposit({ value: Amount });
        await txn_deposit.wait();
        // const provider = new ethers.providers.Web3Provider(window.ethereum);
        // const balance = await provider.getBalance(deployContract.address);
        // console.log(balance);
        
  
    })
})