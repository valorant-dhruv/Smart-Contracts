//SPDX-License-Idetifier:UNLICENSED

pragma solidity >=0.5.0 <0.9.0;

//This is the smart contract where we are generating a random number on chain
contract Randomness{

    uint256 public nonce = 0;

    //This is the function that returns the block number
    //Also the block number gets increased every time
    function blockno() public view returns(uint)
    {
        return block.number;
    }

    //This is the function that returns the hash of the previous block
    function gethash() public view returns(bytes32)
    {
        return blockhash(block.number-1);
    }

    function getrandomhash() public view returns(bytes32)
    {
         bytes32 temp=gethash();
         bytes32 hash = keccak256(abi.encodePacked(temp, address(this), nonce));
         return hash;
    }

    function getrandomfromhash() public view returns(uint)
    {
        bytes32 temp=getrandomhash();
        return uint256(temp);
    }

    //Now this is the function which returns a random number
    function getrandom() public view returns(uint)
    {
         
        uint temp=getrandomfromhash();
        return temp%16;
    
    }
    
}