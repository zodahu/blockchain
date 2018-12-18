pragma solidity ^0.5.0;

interface Auction {

    function bid() payable external;

    function end() external;
}