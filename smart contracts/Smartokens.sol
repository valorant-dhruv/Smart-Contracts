// SPDX-License-Identifier: GPL-3.0

pragma solidity 0.8.14;

import { ISuperToken, IERC20 } from "@superfluid-finance/ethereum-contracts/contracts/interfaces/superfluid/ISuperToken.sol";
import { IFakeDAI } from "./IFakeDAI.sol";

// Deploy this contract on **Goerli Testnet** to begin experimenting
// Alternatively, use pre-deployed contract at 0x7c7A61e744be5abA305701359e44714EC7e71fc5 and this as an interface for interacting on Remix
contract WorkWithSuperTokens {

    // ISuperToken public goerlifDAIx = ISuperToken(0xF2d68898557cCb2Cf4C10c3Ef2B034b2a69DAD00);
    ISuperToken public mumbaifDAIx = ISuperToken(0x5D8B4C2554aeB7e86F387B4d6c00Ac33499Ed01f);

    /// @dev Mints 10,000 fDAI to this contract and wraps (upgrades) it all into fDAIx
    ///      fDAI has a convenient public mint function so we can get as much as we need
    function gainfDAIx() external {

        // Get address of fDAI by getting underlying token address from DAIx token
        // IFakeDAI fDAI = IFakeDAI( goerlifDAIx.getUnderlyingToken() );
        IFakeDAI fDAI = IFakeDAI(0x15F0Ca26781C3852f8166eD2ebce5D18265cceb7);
        
        // Mint 10,000 fDAI
        fDAI.mint(address(this), 10000e18);

        // Approve fDAIx contract to spend fDAI
        // fDAI.approve(address(goerlifDAIx), 20000e18);
        fDAI.approve(address(mumbaifDAIx), 20000e18);

        // Wrap the fDAI into fDAIx
        // goerlifDAIx.upgrade(10000e18);
        mumbaifDAIx.upgrade(10000e18);

        

    }

    function transfertosender() public{
        uint256 DAIxbalance=getfDAIxBalance();
        // goerlifDAIx.transfer(msg.sender,DAIxbalance);
        mumbaifDAIx.transfer(msg.sender,DAIxbalance);
    }

    /// @dev Unwraps (downgrades) chosen amount of fDAIx into DAIx
    /// @param amount - quantity of fDAIx being downgraded
    function losefDAIx(uint256 amount) external {

        // Unwrap the fDAIx into fDAI
        // goerlifDAIx.downgrade(amount);
        mumbaifDAIx.downgrade(amount);

    }

    /// @dev Show fDAI balance of this contract
    /// @return Balance of fDAI in this contract
    function getfDAIBalance() public view returns(uint256) {

        // Get address of fDAI by getting underlying token address from DAIx token
        // IFakeDAI fDAI = IFakeDAI( goerlifDAIx.getUnderlyingToken() );
        IFakeDAI fDAI = IFakeDAI( mumbaifDAIx.getUnderlyingToken() );

        return fDAI.balanceOf(address(this));

    }

    /// @dev Show fDAIx balance of this contract
    /// @return Balance of fDAIx in this contract
    function getfDAIxBalance() public view returns(uint256) {

        return mumbaifDAIx.balanceOf(address(this));

    }

}