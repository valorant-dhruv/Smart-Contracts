//SPDX-License-Identifier:UNLICENSED

pragma solidity >=0.5.0 <0.9.0;

contract mappings{

    struct student{
        string name;
        uint age;
    }
    mapping(uint=>student) public data;

    function create(uint roll,string memory name,uint age) public{
        data[roll]=student(name,age);
    }
}