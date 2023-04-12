//SPDX-License-Identifier:UNLICENSED

pragma solidity >=0.5.0 <0.9.0;

contract publics{

    //State variable as public
    uint private age;

    //Function as public
    function setter(uint _age) private {
        age=_age;
    }
}

//Derieved contract
contract derieved is publics{
    //Both the variable as well as the function cannot be accessed because they are private even in the derived contract
    // uint public age2=age;
    
    // function calling() public
    // {
    //     setter(10);
    // }
}

//Some other contract
contract anothercontract{

    //Here let us create an object of the contract
    //Here the contract is not a derieved contract and hence we cannot  access the private elements
    publics student=new publics();
    function calling() public 
    {
        // student.setter(20);
    }
}