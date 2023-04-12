//SPDX-License-Identifier:MIT
pragma solidity ^0.8.0;

contract Will
{
    /*
    Types of property 
    movable and immovable property
    A will is created by the lawyer
    two people in proof verfies the will 
    */

    uint private count=0;
        
       struct Create_will
       {
           address Owner;
           string Owner_name;
           string property_type;
           string property_description;
           string property_declartion;
           string cid;
       }

       //0x5B38Da6a701c568545dCfcB03FcB875f56beddC4,"Hello","This is my property 1","Property is good","My son A gets 50 and son B gets 50","1"

    Create_will[] public create_will;
    mapping(address=>uint[])public Will_Link;
    function WillCreate(address _Owner,string memory _OwnerName,string memory _Property_type,string memory _property_description,string memory _property_declartion,string calldata _cid)public
    {
        //Inside the Will create
        //We assign all the details of the struct
        //Then after creating the struct we 
        create_will.push(Create_will({Owner:_Owner,Owner_name:_OwnerName,property_type:_Property_type,property_description:_property_description,property_declartion: _property_declartion,cid:_cid}));
        Will_Link[msg.sender].push(count);
        count+=1;

    }

   function getwillnumber() public view returns(uint[] memory)
   {
    //    uint [] memory temp;
    //    uint tempvar=0;

    //    for(uint i=0;i<count;i++)
    //    {
    //        if(Will_Link[i]==msg.sender)
    //        {
    //            temp[tempvar]=i;
    //            tempvar++;
    //        }
    //    }

    return Will_Link[msg.sender];

   }

    function getwilldetail(uint _num) public view returns(address _Owner,string memory _OwnerName,string memory _Property_type,string memory _property_description,string memory _property_declartion,string memory _cid)
    {
        Create_will memory temp=create_will[_num];
        return (temp.Owner,temp.Owner_name,temp.property_type,temp.property_description,temp.property_declartion,temp.cid);
    }
  

    
}