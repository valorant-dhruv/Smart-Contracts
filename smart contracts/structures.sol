//SPDX-License-Identifier:UNLICENSED

pragma solidity >=0.5.0 <0.9.0;

contract structures{

    //This is the student structure
    struct student{
        uint roll;
        string name;
    }

    //Now we are creating a variable of the student data type
    student public s1;

    //Constructor to intialize the values of the student
    constructor(uint _roll,string memory _name)
    {
        s1.roll=_roll;
        s1.name=_name;
    }

    //Function to change the value of the student s1
    function change(uint rollnew,string memory namenew) public {
        //We can simply do s1.roll=rollnew 
        //However here we are learning a new syntax 
        student memory s2=student({
            roll:rollnew,
            name:namenew
        });

        s1=s2;
    }
}