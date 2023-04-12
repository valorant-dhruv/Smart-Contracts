//SPDX-License-Identifier:UNLICENSED
pragma solidity >=0.5.0 <0.9.0;
contract Strings {
    function concatenate(string memory str1, string memory str2)
        public
        pure
        returns (string memory)
    {
        //Let us say the two strings are str1="dhr" and str2="uv"
        //Now we convert both these strings into dynamic bytes 

        //str_bytes1 becomes 0x646872
        bytes memory str_bytes1 = bytes(str1);

        //str_bytes2 becomes 0x7576
        bytes memory str_bytes2 = bytes(str2);

        //Now this is the final string that is the sum of length of both the strings bytes 
        string memory str = new string(str_bytes1.length + str_bytes2.length);
       //Now the str_bytes will look something like this: 0x0000000000
       //Length is 5
        bytes memory str_bytes = bytes(str);
   
        //Using loops we now assign each byte of the str_bytes with the respective bytes of the str_bytes1 and 2
        uint256 k = 0;
        for (uint256 i = 0; i < str_bytes1.length; i++) {
            str_bytes[k] = str_bytes1[i];
            k++;
        }
        for (uint256 i = 0; i < str_bytes2.length; i++) {
            str_bytes[k] = str_bytes2[i];
            k++;
        }
        return string(str_bytes);
    }
}