//SPDX-License-Identifier:UNLICENSED

pragma solidity >=0.5.0 <0.9.0;

//This is the smart contract that has a function calculateHash
//What this function does is that it accepts a string as a secret
//Then from the string that is passed it creates a hash from it using the keccak256 function(in built function of solidity)
//This function also wants bytes as an argument so for that reason we have used abi.encodePacked(_key) which converts 
//the string into bytes
contract Hash{
    function calculateHash(string memory _key) external pure returns(bytes32)
    {
        //The keccak256 is a hashing function
        return keccak256(abi.encodePacked(_key));
    }
}

