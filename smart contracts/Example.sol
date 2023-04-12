//SPDX-License-Identifier:MIT

import "https://github.com/OpenZeppelin/openzeppelin-contracts/blob/master/contracts/access/Ownable.sol";

pragma solidity >=0.5.0 <0.9.0;

//Contract address
//0x5002474b51E93ffb249b4943088d30eEb4d089bC

contract Example is Ownable{
    //This is the state variable that is 
    string public name="Dhruv";

    function changename(string calldata _name) public returns(bool)
    {
        require(msg.sender==owner(),"The owner must call this function");
        name=_name;
        return true;
    }


}