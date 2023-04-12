//SPDX-License-Identifier:UNLICENSED

pragma solidity >=0.5.0 <0.9.0;

contract testing1{
    //This is the state variable
    uint public age=10;

    function get() public view returns(uint)
    {
        return age;
    }

    function set(uint _age) public{
        age=_age;
    }
}