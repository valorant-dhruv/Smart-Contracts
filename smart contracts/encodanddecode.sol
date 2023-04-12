//SPDX-License-Identifier:MIT

pragma solidity >=0.5.0 <=0.9.0;

contract encodeanddecode{

    //Now this is the function for encoding the data that was passed
    //What encoding does is that it converts the data that is passed inside the function
    //to bytes
    function encode(uint num,string memory name) external returns(bytes memory)
    {
        return abi.encode(num,name);
    }

    //This is the function for decoding the data
    //What decoding does is that it converts the bytes data that was passed back to the original data
    function decode(bytes calldata data) external returns(uint num,string memory name)
    {
        (num,name)=abi.decode(data,(uint,string));
    }
    
}