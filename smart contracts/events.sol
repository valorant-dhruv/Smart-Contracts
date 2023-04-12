//SPDX-License-Identifier:UNLICENSED

pragma solidity >=0.5.0 <0.9.0;

contract events{
    uint public age;

    constructor()
    {
        age=10;
    }

    event student(address sender,uint ages);

    function eventtrigger() public returns(uint){
        emit student(msg.sender,age);
        return age;
    }
}