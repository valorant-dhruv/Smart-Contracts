//SPDX-License-Identifier:MIT

pragma solidity ^0.8.0;

import 'https://github.com/OpenZeppelin/openzeppelin-contracts/blob/master/contracts/token/ERC20/ERC20.sol';

contract Server is ERC20{
    constructor() ERC20("SERVER", "SER") {
    }

    function mint(uint256 tokenamount) external{
        _mint(msg.sender, tokenamount);
    }
}