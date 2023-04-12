//SPDX-License-Identifier:UNLICENSED

pragma solidity >=0.5.0 <0.9.0;

//Parent contract

contract  parent{
    uint public age;
    string public  name;

    constructor()
    {
        age=20;
        name="dhruv";
    }

    function set(uint _age) public{
        age=_age;
    }
}

//This is the inherited child contract
contract child is parent{
    uint public  roll_no;
}