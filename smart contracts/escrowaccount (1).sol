//SPDX-License-Identifier: GPL-3.0

pragma solidity >=0.5.0 <0.9.0;

//Here we are creating an escrow account
//An escrow account is basically a third party account that a company holds
//It acts as an intermediate between the sender and receiver of funds
contract Escrow {
  //The state variables
  //payer
  address public  payer;
  //payee
  address payable public payee;
  //third party
  address payable public thirdParty;
  //amount
  uint public amount;
 
 //The constructor assigns the addresses to the payee ,payer and the thirdparty and assigns the amount to the amount
  constructor(address _payer,address _payee,uint _amount)
  {
    payer=_payer;
    payee=payable(_payee);
    thirdParty=payable(msg.sender);
    amount=_amount;
  }

 //This is a payable function which means that here the payer can add their funds to the deposit
  function deposit() public payable
  {
    require(payer==msg.sender,"Sender must be the payer");

    //This means that the depositer is the payer only
    require(amount<=address(this).balance,"Cant send more than escrow amount");

    //This means that the amount that the payer wants to send is less than the total balance of the account
  }

  //This release function basically sends the money deposited by the payer to the payee
  function release() public {
    require(amount==address(this).balance, "cannot release funds before the full amount is sent");
    require(thirdParty==msg.sender,"only third party can release funds");
    payee.transfer(amount);
  } 
   
  //This function simply checks the balance of the escrow account
   function balanceOf() public view returns (uint256) {
        return address(this).balance;
    }
}