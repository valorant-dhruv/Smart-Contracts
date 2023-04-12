//SPDX-License-Identifier:UNLICENSED

pragma solidity >=0.5.0 <0.9.0;

//Parent contract

abstract contract  a_parent{
    uint public age;
    string public  name;

    constructor()
    {
        age=20;
        name="dhruv";
    }

    //This is the function that the child contracts need to implement
    function set(uint _age) public virtual;
}

//This is the inherited child contract 
contract child is a_parent{
    uint public  roll_no;

    function set(uint _age) public override{
        age=_age;
    }
}