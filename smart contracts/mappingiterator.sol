//SPDX-License-Identifier:UNLICENSED

pragma solidity >=0.5.0 <0.9.0;

contract mappingiterator{

    mapping(address=>uint) public account;

    address[] public track;
    //This is the function that the person calls

    function create(uint value) public{
        account[msg.sender]=value;
        track.push(msg.sender);
    }

    function getarray() public view returns(address[] memory)
    {
        return track;
    }

}