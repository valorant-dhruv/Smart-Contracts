//SPDX-License-Identifier:UNLICENSED

pragma solidity >=0.5.0 <0.9.0;

//There are 2 ways to implement the ERC20 interface

//First is to just import the contract that is written by the open Zipplen which is a security company
//if a security company such as Open Zeppelin is providing the community with certified contracts, then,
// It is better leverage the ERC20 token logic creation to a security company, and focus on the contracts for application

//The second way is to just copy paste the interface that is written in the ethereum community

interface ERC20Interface { 
    function totalSupply() external view returns (uint);
    function balanceOf(address tokenOwner) external view returns (uint balance); 
    function transfer(address to, uint tokens) external returns (bool success);

    function allowance(address tokenOwner, address spender) external view returns (uint remaining);
    function approve(address spender, uint tokens) external returns (bool success);
    function transferFrom(address from, address to, uint tokens) external returns (bool success);

    event Transfer(address indexed from, address indexed to, uint tokens);
    event Approval(address indexed tokenOwner, address indexed spender, uint tokens);
}

//Hence these are all the functions that we need to implement in our contract.

//Our token contract
contract Dhruv is ERC20Interface{
    //Name of tje token
    string public name="Satoshi Soni";

    //Symbol of the token
    string public symbol="SDS";

    //The decimal places upto which the token can be divided
    uint public decimal=0;
    
    //This is the total supply of the tokens that will be available in this smart contract
    //There cannot be any more tokens created than the total supply
    uint public totalsupply=100000;

   //This is the function which implements the totalSupply function of the interface
   //It returns the value of the total supply;
    function totalSupply() override public view returns(uint){
        return totalsupply;
    }

    //This is the address of the creator of the smart contract
    address public creator;

    //Now this is the mapping data type which maps each address to a specific token amount
    mapping(address=>uint) public amount;

    constructor()
    {
        creator=msg.sender;

        //Intially all the tokens are available to the creator of the contract
        amount[creator]=totalsupply;
    }


    //Now we are implementing the balanceof function which takes in the address of the token owner as an argument
    //It returns the balance that the token owner has
    function balanceOf(address tokenOwner) public override view returns(uint)
    {
        return amount[tokenOwner];
    }

    //Now we are implementing the transfer function where the any acciount  of the smart contract can transfer the tokens 
    //to another account address
    function transfer(address to,uint tokens) public override returns(bool){
        //Checking whether the sender of the tokens has enough tokens to send to other
        require(tokens<=amount[msg.sender],"The sender cannot send tokens more than the he/she owns");

        //Adding the tokens to the account
        amount[to]+=tokens;

        //Removing the tokens from the sender's account
        amount[msg.sender]-=tokens;

       emit Transfer(msg.sender,to,tokens);
        return true;
    }



    //The approve function means that the person is telling the spender that you are now allowed to spend my tokens 

    //For this we first need to create another mapping for approved
    //This is the nested mapping
    mapping (address=>mapping(address=>uint)) public approved;

    //The approve function is just like writing a cheque to another person to ensure that the other person can access
    //this much funds of my account
    function approve(address spender,uint tokens) public override returns(bool)
    {
        //The amount in the msg.sender of the function is greater than what he/she is allowing the spender to spend
        require(amount[msg.sender]>=tokens);
        require(tokens>0);

        approved[msg.sender][spender]=tokens;
        return true;
    }

    //The allowance function means the number of tokens that the tokenowner has allowed for the spender to spend
    //It is just like returning the cheque amount that  the sender has allowed to other person
    function allowance(address tokenOwner, address spender) public override view returns (uint)
    {
        return approved[tokenOwner][spender];
    }

    //Finally we have the transfer from function
    //Here we have two arguments the from and to function which allows to send the tokens from one to another
    function transferFrom(address from,address to,uint tokens) public override  returns(bool)
    {
        //We first need to check in the approved mapping whether the tokens are greater than the argument
        require(approved[from][to]>=tokens);
        require(amount[from]>=tokens);

        amount[from]-=tokens;
        amount[to]+=tokens;

        emit Transfer(msg.sender,to,tokens);
        return true;

    }



}