//SPDX-License-Identifier:MIT
//pragma solidity >=0.5.0 <0.9.0;

contract Checkwill{
    mapping(address=>uint) public assigned;

    function assign(uint number) public{
        assigned[msg.sender]=number;
    }
}

