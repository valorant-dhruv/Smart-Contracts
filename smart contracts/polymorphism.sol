//SPDX-License-Identifier:UNLICENSED

pragma solidity >=0.5.0 <0.9.0;

contract poly{
    function sum(uint a,uint b) public pure returns(uint)
    {
        return a+b;
    }

    function sum(uint a,uint b,uint c) public pure returns(uint)
    {
        return a+b+c;
    }

    function sum(string memory a,string memory b) public pure returns(string memory)
    {
        return a;
    }
}