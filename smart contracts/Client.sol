//SPDX-License-Identifier:MIT

pragma solidity ^0.8.0;

import 'https://github.com/OpenZeppelin/openzeppelin-contracts/blob/master/contracts/token/ERC20/ERC20.sol';

contract Client is ERC20{
    constructor() ERC20("CLIENT", "CLI") {
    }

    function mint(uint256 tokenamount) external{
        _mint(msg.sender, tokenamount);
    }
}