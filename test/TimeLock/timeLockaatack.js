const { ethers } = require("hardhat");

describe("time lock Attack", function () {
    let deployContract, address1;

    it("Contract Deployment", async function () {
        [...address1] = await ethers.getSigners();
        const AttackCotract = await ethers.getContractFactory("timeLock_Attack");
        deployContract = await AttackCotract.deploy("0x5FbDB2315678afecb367f032d93F642f64180aa3");
        await deployContract.deployed();
        console.log("Contract Address :", deployContract.address);
    })
    it("Calling time lock Attack function", async function () {
        let Amount = ethers.utils.parseEther("1");
        const txn_attack = await deployContract.connect(address1[2]).attack({ value: Amount });
        await txn_attack.wait();
        const provider = new ethers.providers.Web3Provider(window.ethereum);
        const balance = await provider.getBalance(deployContract.address);
        console.log(balance);
    })
})