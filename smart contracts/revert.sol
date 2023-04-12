//SPDX-License-Identifier:UNLICENSED

pragma solidity >=0.5.0 <0.9.0;

contract revertfunction{
    uint public balance=10;

    //This function takes in an amount and checks whether the amount is greate than the balance or not
    function check(uint amount) public view returns(uint)
    {
        // require(balance<=amount,"The amount entered cannot be greater than the balance");
        // return balance;

        if(balance>amount)
        {
            return balance;
        }
        else{
            revert("The amount cannot be greater than the balance");
        }
    }
}