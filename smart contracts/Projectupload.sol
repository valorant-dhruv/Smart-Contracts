//SPDX-License-Identifier:MIT

pragma solidity >=0.5.0 <0.9.0;


//This is the smart contract which will trigger various events whenever the project is uploaded
contract Projectupload{

    //We also need the adminLogin smart contract to check whether the admin is available or not to check whether the
    //Hence this is the state variable of the admin login
    // Adminlogin admin;
    address owner;
    constructor(address _owner)
    {
        owner=_owner;
        // admin=Adminlogin(_admin);
    }

    event Hii(string greeting);

    function greeting() public{
        emit Hii("Hello there");
    }

    //So majorly two events will be triggered
    //The first event is triggered when the user uploads the project along with the ipfs link and that event is sent to the admin 
    //of that particular university
    event Uploaded(address indexed student,address indexed admin,uint projectid,string  university,uint  date);

    //The second event is triggered whenever the admin of the university is not found and this event is triggered to the owner
    event Adminna(address indexed student, address indexed owner,string indexed university,uint  date);

    function ProjectUploaded(address sender,address admin,string memory projectid,string memory university) external{
        emit Uploaded(sender,admin,projectid,university,block.timestamp);
    }

}