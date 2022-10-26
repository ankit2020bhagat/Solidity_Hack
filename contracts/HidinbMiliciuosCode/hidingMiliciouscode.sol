// SPDX-License-Identifier: MIT
pragma solidity ^0.8.7;

contract Foo{

    Bar bar;
    //Bar public bar;

    constructor(address _bar) {
        bar = Bar(_bar);
    }

    // constructor (){
    //      bar = new Bar();
    // }

    function callBar() public {
        bar.log();
    }

}

contract Bar{

    event Log(string messsage);

    function log() public {
        emit Log("Bar id called");
    }
     
}

contract Mal{

    event Log(string message);

    function log() public {
        emit Log("Mal Is called");
    }
}