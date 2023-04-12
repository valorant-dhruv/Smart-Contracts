//SPDX-License-Identifier:MIT

pragma solidity ^0.8.0;

contract C{

    function returnhex() public returns(bytes memory){
        return abi.encodeWithSignature("pwn()");
    }

    
}
