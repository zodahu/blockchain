pragma solidity ^0.5.0;

import "./Auction.sol";

contract BaseAuction is Auction {

    address public owner;

    modifier OwnerOnly() {
        require(msg.sender == owner, "msg.sender != owner");
        _;
    }

    event AuctionComplete(address winner, uint bid);

    constructor() public {
        owner = msg.sender;
    }
}