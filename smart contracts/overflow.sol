//SPDX-License-Identifier:MIT

pragma solidity >=0.5.0 <0.9.0;

contract Overflow{
    uint8 public num1=100;
    uint8 public num2=157;

    function add() public view returns(uint8)
    {
        return num1+num2;
    }
}