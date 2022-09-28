const {ethers} = require("hardhat");

describe.only("TimeLock",function(){
    let deployContract,addresses
    it("Contract Deployment",async function(){
       [...addresses] =await ethers.getSigners();
       const TimeLockcontract = await ethers.getContractFactory("TimeLock");
       deployContract= await TimeLockcontract.deploy();
       await deployContract.deployed();
       console.log("Contract Address: ",deployContract.address);
    })

    it("Calling deposit function ",async function(){
        let Amount =  ethers.utils.parseEther("1");
        let txn_deposit = await deployContract.deposit({value:Amount});
        await txn_deposit.wait();
         txn_deposit = await deployContract.connect(addresses[1]).deposit({value:Amount});
        await txn_deposit.wait();
        console.log("Contract Balance :",await deployContract.getBalance())
    })

    // it("Calling withdraw function ",async function(){
    //    const txn_withdraw= await deployContract.connect(addresses[1]).withdraw();
    //    await txn_withdraw.wait();
    //    const provider = new ethers.providers.Web3Provider(window.ethereum);
    //    const balance = await provider.getBalance(addresses[1].address);
    //    console.log(balance);
    // })
})