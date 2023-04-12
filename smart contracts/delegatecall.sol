//SPDX-License-Identifier:MIT

pragma solidity >=0.5.0 <=0.9.0;

//In this code there are 3 smart contracts A,B and C
//The B smart contract function is having a delegatecall on the function of smart contract C
//The smart contract A is having a simple call on the function of smart contract B

//This is the smart contract C
contract C{
    uint public  num;
    address public sender;
    uint public value;

    function foo(uint _num) external payable{
        num=_num;
        sender=msg.sender;
        value=msg.value;
    }
}


//This is the smart contract B
contract B{
    //For comparison the B smart contract also have the same state variables as the C smart contract
    uint public num;
    address public  sender;
    uint public value;
    function foo(uint _num,address _C) external payable returns(bool){
       (bool success,bytes memory data)=_C.delegatecall(abi.encodeWithSelector(C.foo.selector,_num));
       require(success==true,"The call to the C function got failed");
       return true;
    }
}

//This is the smart contract A

contract A{

    bool public data;
    function callfoo(address _B,address _C) external payable{ 
       (bool success,bytes memory _data)= _B.call{value:msg.value}(abi.encodeWithSelector(B.foo.selector,5,_C));
       data=abi.decode(_data,(bool));
    }

}