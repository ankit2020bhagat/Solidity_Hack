const {ethers} = require("hardhat");

describe("Re-Entracy Attack",function(){
    let deployContract,addresses;
    
    it("Contract Deployement",async function(){
       [...addresses]= await ethers.getSigners();
      const EtherStoreContract = await ethers.getContractFactory("EtherStore");
      deployContract = await EtherStoreContract.deploy();
      await deployContract.deployed();
      console.log("Contract Address :",deployContract.address);
      console.log("Address[1]",addresses[0].address);
    })

    it("Calling deposit function ",async function(){
      let Amount = ethers.utils.parseEther("1"); 
      let txn_deposit = await deployContract.deposit({value:Amount});
      await txn_deposit.wait();
      console.log("Contract Balance :",await deployContract.getBalance());
      Amount = ethers.utils.parseEther("2"); 
      txn_deposit = await deployContract.connect(addresses[1]).deposit({value:Amount});
      await txn_deposit.wait();
      console.log("Contract Balance :",await deployContract.getBalance());
      Amount = ethers.utils.parseEther("3"); 
      txn_deposit = await deployContract.connect(addresses[2]).deposit({value:Amount});
      await txn_deposit.wait();
      console.log("Contract Balance :",await deployContract.getBalance());

      
    })

    // it("Calling withdraw function",async function(){
    //   const txn_withdraw = await deployContract.connect(addresses[2]).withdraw();
    //   await txn_withdraw.wait();
    //   console.log("contract Balance :",await deployContract.getBalance());
    // })


})

