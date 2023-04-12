//SPDX-License-Identifier:UNLICENSED

pragma solidity >=0.5.0 <0.9.0;

contract soapcompany{

    //This is the array which keeps track of all the soaps
    soap[] public soaps;

    //Now there is a function where each time the company wants to create a new soap it calls this function
    function create() public{
        soap temp=new soap();
        soaps.push(temp);
    }
}

contract soap{
    uint public price;
    string public desc;
}