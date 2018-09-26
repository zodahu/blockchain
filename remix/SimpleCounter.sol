pragma solidity ^0.4.0;

contract SimpleCounter {
    int256 counter;
    address owner;

    constructor() public {
        counter = 0;
        owner = msg.sender;
    }
    
    function getCounter() public view returns(int) {
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