//SPDX-License-Identifier:MIT

pragma solidity >=0.5.0 <0.9.0;

contract Simplesmartcontract{

    string public name="dhruv";
    event NameAccessed(string indexed name);
    function getname() public returns(string memory)
    {
        string memory _name=name;
        emit NameAccessed(_name);
        return _name;
    }
}