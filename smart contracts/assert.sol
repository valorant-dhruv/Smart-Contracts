//SPDX-License-Identifier:UNLICENSED

pragma solidity >=0.5.0 <0.9.0;

contract understand{
    uint public balance=0;

    function add(uint amount) public{
        balance+=amount;
        assert(balance<=20);
    }
}