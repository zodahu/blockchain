pragma solidity ^0.5.0;

import "./Baseauction.sol";

contract TimerAuction is BaseAuction {

    string public item;
    uint public auctionEnd;
    address payable public maxBidder;
    uint public maxBid;
    bool public ended;

    event BidAccepted(address bidder, uint bid);

    constructor(uint _durminutes, string memory _item) public {
        item = _item;
        auctionEnd = now + (_durminutes * 1 minutes);
    }

    function bid() payable public {
        require(now < auctionEnd, "now >= auctionEnd");
        require(msg.value > maxBid, "msg.value <= maxBid");

        if (maxBidder != address(0)) {
            maxBidder.transfer(maxBid);
        }

        maxBidder = msg.sender;
        maxBid = msg.value;

        emit BidAccepted(maxBidder, maxBid);
    }

    function end() public OwnerOnly {

    }
}