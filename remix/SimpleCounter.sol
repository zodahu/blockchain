pragma solidity ^0.4.0;

contract SimpleCounter {
    int256 counter;
    address owner;

    constructor() public {
        counter = 0;
        // msg.sender varies based on who interacts with the contract,
        // owner is the first msg.sender who deployed the contract
        owner = msg.sender;
    }

    function getCounter() public view returns(int) { // view: promise not to modify the state
        return counter;
    }
    
    function increment() public {
        counter += 1;
    }
    
    function decrement() public {
        counter -= 1;
    }
    
    function reset() public {
        require(msg.sender == owner, "sender != owner");
        counter = 0;
    }
}