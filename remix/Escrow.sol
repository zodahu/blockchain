pragma solidity ^0.5.0;

contract Escrow {

    enum State {AWAITING_PAYMENT, AWAITING_DELIVERY, COMPLETE, REFUNDED}
    State public currentState;

    address payable public buyer;
    address payable public seller;
    address public arbiter;

    modifier buyerOnly() {
        require(msg.sender == buyer, "msg.sender != buyer");
        require(msg.sender == arbiter, "msg.sender != arbiter");
        _;
    }

    modifier sellerOnly() {
        require(msg.sender == seller, "msg.sender != seller");
        require(msg.sender == arbiter, "msg.sender != arbiter");
        _;
    }

    modifier requireState(State expectedState) {
        require(currentState == expectedState, "currentState != expectedState");
        _;
    }

    constructor(address payable _buyer, address payable _seller, address _arbiter) public {
        buyer = _buyer;
        seller = _seller;
        arbiter = _arbiter;
    }

    function norifyPayment() public buyerOnly requireState(State.AWAITING_PAYMENT) payable {
        currentState = State.AWAITING_DELIVERY;
    }

    function confirmDelivery() public buyerOnly requireState(State.AWAITING_DELIVERY) {
        seller.transfer(address(this).balance);
        currentState = State.COMPLETE;
    }

    function refundBuyer() public sellerOnly requireState(State.AWAITING_DELIVERY)  {
        buyer.transfer(address(this).balance);
        currentState = State.REFUNDED;
    }
}