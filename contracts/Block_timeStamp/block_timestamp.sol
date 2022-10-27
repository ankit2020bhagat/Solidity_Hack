// SPDX-License-Identifier: MIT
pragma solidity 0.8.9;

contract Roulette {

    uint public pastBlock;

    constructor () payable {}

    function spin () public payable returns (uint){

        if (msg.value <10 ether){
            revert();
        }

        if(block.timestamp==pastBlock){
            revert();
        }

        pastBlock = block.timestamp;

        if(block.timestamp % 15==0){
           (bool sucess,) = msg.sender.call{value : address(this).balance}("");
           if(!sucess){
               revert();
           }
        }

        return  block.timestamp;
    }
}