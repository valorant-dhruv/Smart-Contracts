//SPDX-License-Identifier:MIT

pragma solidity >=0.5.0 <=0.9.0;

//This is the test smart contract whose function is going to be called
contract Testdhruv{
    
    //This is the event that is emitted inside the fallback
    event Log(string err);

    //This is the function that will be called
    function foo(uint num) external payable returns(uint)
    {
        return num;
    }

    //In case no function of the smart contract is called the fallback function will be executed
    fallback() external payable{
        emit Log("The function you are trying to call is not found");
        payable(msg.sender).transfer(msg.value);
    }
}

//This is the main smart contract that is calling the function
contract dhruv{

    bytes public data;

    //Writing the uint256 instead of uint is important
    function callfoo(address _testdhruv) external payable{
        (bool success, bytes memory _data)=_testdhruv.call{value:100}(abi.encodeWithSignature("foo(uint256)",5));
        require(success==true,"The call to the function has failed");
        data=_data;
    }

    function getreturneddata() external returns(uint num)
    {
        (num)=abi.decode(data,(uint));
    }
}