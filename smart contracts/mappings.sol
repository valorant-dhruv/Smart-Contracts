//SPDX-License-Identifier:UNLICENSED

pragma solidity >=0.5.0 <0.9.0;

contract mappings{
    
    //Mapping data type student
    //Here we are mapping a integer to a string which means the integer is the key and the string is the value
    mapping(uint=>string) public student;

    function create(uint roll,string memory name) public{
        student[roll]=name;
    }
}