// SPDX-License-Identifier: MIT
pragma solidity ^0.8.7;

contract Immutable {
    // coding convention to uppercase constant variables
    address public immutable MY_ADDRESS;
    uint public immutable MY_UINT;

    mapping(string=>uint) public ids;

    function set(string memory _name,uint id) public {
        ids[_name]=id;
    }



    constructor(uint _myUint) {
        MY_ADDRESS = msg.sender;
        MY_UINT = _myUint;
    }

}
