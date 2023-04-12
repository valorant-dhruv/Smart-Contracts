//SPDX-License-Identifier:UNLICENSED

pragma solidity >=0.4.0 <0.8.0;

contract trial{
    mapping(address=>bool) public tp;

    function get(address _tp) public returns(bool)
    {
        return tp[_tp];
    }
}