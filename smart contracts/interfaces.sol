//SPDX-License-Identifier:UNLICENSED
pragma solidity >=0.5.0 <0.9.0;
//Parent contract
interface parent{

    //The state variables are not allowed
    // uint public age;
    // string public  name;

    //A constructor is not allowed
    // constructor()
    // {
    //     age=20;
    //     name="dhruv";
    // }

    function set(uint _age)  external;
}

//This is the inherited child contract
contract child is parent{
    uint public  roll_no;
    uint public age;

    function set(uint _age) public override{
        age=_age;
    }
}