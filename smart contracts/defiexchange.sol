//SPDX-License-Identifier:UNLICENSED

pragma solidity >=0.5.0 <0.9.0;
import "https://github.com/OpenZeppelin/openzeppelin-contracts/blob/master/contracts/token/ERC20/ERC20.sol";
import "https://github.com/OpenZeppelin/openzeppelin-contracts/blob/master/contracts/access/Ownable.sol";

  contract Dhruvtokens is ERC20, Ownable {
      // Price of one Crypto Dev token
      uint256 public constant tokenPrice = 0.001 ether;
    
      // the max total supply is 10000 for Crypto Dev Tokens
      uint256 public constant maxTotalSupply = 10000 * 10**18;

      constructor() ERC20("Dhruv tokens", "DTC") {
      }


      function mint(uint256 amount) public payable {
          // the value of ether that should be equal or greater than tokenPrice * amount;
          uint256 _requiredAmount = tokenPrice * amount;
          require(msg.value >= _requiredAmount, "Ether sent is incorrect");
          // total tokens + amount <= 10000, otherwise revert the transaction
          uint256 amountWithDecimals = amount * 10**18;
          require(
              (totalSupply() + amountWithDecimals) <= maxTotalSupply,
              "Exceeds the max total supply available."
          );
          // call the internal function from Openzeppelin's ERC20 contract
          _mint(msg.sender, amountWithDecimals);
      }
  }
contract Defi{
    Dhruvtokens public dhruv;
    string public name;
    constructor(address _defi) 
    {
        dhruv=Dhruvtokens(_defi);
    }

    function naming() public
    {
        name=dhruv.name();
    }

    function minting() external payable returns(bool)
    {
        dhruv.mint{value:0.01 ether}(10);
        return true;
    }
}