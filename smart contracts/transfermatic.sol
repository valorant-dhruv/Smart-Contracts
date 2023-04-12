//SPDX-License-Identifier:UNLICENSED
import "https://github.com/OpenZeppelin/openzeppelin-contracts/blob/master/contracts/token/ERC20/ERC20.sol";
import "https://github.com/OpenZeppelin/openzeppelin-contracts/blob/master/contracts/utils/Context.sol";
import "https://github.com/OpenZeppelin/openzeppelin-contracts/blob/master/contracts/token/ERC20/IERC20.sol";

pragma solidity >=0.5.0 <0.9.0;

contract TransferMatic is Context{b

    //In this smart contract there are two variables
    //One is the matic contract address
    //The second is the address of the company metamask account
    address public tokenaddress;
    address public companyaccount;

    function sendFunds() external payable {
        payable(companyaccount).call{value: msg.value}('');
    }

    bool public transferred=false;

    uint256 balance=0;

    string public passed="failed";

    IERC20 public token;

    //Now this is the fallback function in case the matic was transferred to this account
    fallback() external payable{
        
    }


    //Both the token addresses and the company account are passed inside the constructor
    constructor(address _tokenaddress,address _companyaccount)
    {
        // tokenaddress=_tokenaddress;
        companyaccount=_companyaccount;

        //We have also created an instance of the matic token smart contract
        // token=IERC20(_tokenaddress);
    }

    //Now lets say there is a user with account address acc0
    //The user first approves the company account to a certain amount of matic
    //Then when the approval is done then the user sends the matic to the company wallet

    function sentmatic(uint _tokenvalue) external returns(bool)
    {
        address sender=_msgSender();
        //We first need to check whether the sender actually has that much balance or not
        //Here we are going to call the approve function of the token smart contract
         require(balance>=_tokenvalue,"The sender's matic balance is less than what he/she wishes to transfer");

        // //Now we are approving the company account address to spend this much of matic
        (bool success,bytes memory data) = tokenaddress.delegatecall(
            abi.encodeWithSignature("transfer(address,uint256)",companyaccount,_tokenvalue)
        );

         require(success,"The transaction failed");
        // // token.approve(address(this),_tokenvalue);
        // //Once the account has been approved we can safely transfer the matic
        // // bool value=token.transferFrom(sender,companyaccount,_tokenvalue);
        //  (success,data) = tokenaddress.call(
        //     abi.encodeWithSignature("transferFrom(address,address,uint256)",sender,companyaccount,_tokenvalue)
        // );

        //  require(success,"The transaction failed");

        //  bool value=abi.decode(data,(bool));
        //  transferred=value;


        // if(value)
        // {
        //     return (true,"The transfer is successful");
        // }

        // else{
        //     return (false,"The transfer failed");
        // }

        return true;
    }

    function contractaddress() external view returns(address)
    {
        return tokenaddress;
    }

    function getstring() external view returns(string memory)
    {
        return passed;
    }

    function setname() external
    {
         (bool success, bytes memory data) = tokenaddress.call(
            abi.encodeWithSignature("name()")
        );

         require(success,"The transaction failed");
        //  string memory data2="passed";
        //  string memory data2=abi.decode(data,(string));
         passed=abi.decode(data, (string));
    }

    function getbalance() external view returns(uint256)
    {
        return balance;
    }

    function setbalance() external returns(uint256)
    {
        (bool success, bytes memory data) = tokenaddress.call(
            abi.encodeWithSignature("balanceOf(address)",msg.sender)
        );

         require(success,"The transaction failed");

         balance=abi.decode(data, (uint256));
    }
    
}