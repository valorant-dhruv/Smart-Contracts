// SPDX-License-Identifier: MIT
pragma solidity >=0.5.0 <0.9.0;

contract Wallet {
  //1) User can deposit ether to his wallet
  function depositether() external payable {
   
  }

  //2)The user can send ether to another account address
  //This is the user state variable which contains the address where user wants to send ether
  address payable user=payable(0x5B38Da6a701c568545dCfcB03FcB875f56beddC4);

  //Let us use the concept of polymorphism where we give the user with two options

  function sendether(address user1) public payable{
    payable(user1).transfer(5 ether);
  }

  function sendether() public payable{
    user.transfer(5 ether);
  }

  //3)Check the balance of the ether that the user has
  function checkbalance() public view returns(uint)
  {
    return address(this).balance;
  }

  //This is the fallback function in case someone sends the ether to the user without the sendether function
  fallback() external payable{
    payable(msg.sender).transfer(msg.value);
  }
  
}