//SPDX-License-Identifier:UNLICENSED

pragma solidity >=0.5.0 <0.9.0;

//Now this is the contract that determines the price against each polygon that has been deposited
//If x amount of polygon is deposited then what will be the market price and the uniswap price
import "@chainlink/contracts/src/v0.8/interfaces/AggregatorV3Interface.sol";

contract Pricedetermination{
   
    AggregatorV3Interface internal priceFeed;
    AggregatorV3Interface internal priceFeed2;
    AggregatorV3Interface internal priceFeed3;

    /**
     * Network: Mumbai testnet
     * Aggregator: MATIC/USD
     * Address: 0xd0D5e3DB44DE05E9F294BB0a3bEEaF030DE24Ada
     */

     /**
     Network:Mumbai Testnet
     Aggregator: USDC/USD
     Address:0x572dDec9087154dC5dfBB1546Bb62713147e0Ab0
      */

    /**
    Network:Mumbai Testnet
    Aggregator:USDT/USD
    Address:0x92C09849638959196E976289418e5973CC96d645
     */
    constructor() {
        priceFeed = AggregatorV3Interface(0xd0D5e3DB44DE05E9F294BB0a3bEEaF030DE24Ada);
        priceFeed2=AggregatorV3Interface(0x572dDec9087154dC5dfBB1546Bb62713147e0Ab0);
        priceFeed3=AggregatorV3Interface(0x92C09849638959196E976289418e5973CC96d645);
    }

    /**
     * Returns the latest price
     */
    function getLatestPriceofmatic() private view returns (int) {
        (
            /*uint80 roundID*/,
            int price,
            /*uint startedAt*/,
            /*uint timeStamp*/,
            /*uint80 answeredInRound*/
        ) = priceFeed.latestRoundData();

        return price;
    }

    function getLatestPriceofusdc() private view returns(int)
    {
        (
            /*uint80 roundID*/,
            int price,
            /*uint startedAt*/,
            /*uint timeStamp*/,
            /*uint80 answeredInRound*/
        )=priceFeed2.latestRoundData();
        return price;
    }

    function getLatestPriceofusdt() private view returns(int)
    {
         (
            /*uint80 roundID*/,
            int price,
            /*uint startedAt*/,
            /*uint timeStamp*/,
            /*uint80 answeredInRound*/
        )=priceFeed3.latestRoundData();
        return price;
    }

    function tp() public pure returns(string memory)
    {
        return "Dhruv";
    }

    function getallprices() public view returns(int,int,int,int,int)
    {
        int price1=getLatestPriceofmatic();
        int price2=getLatestPriceofusdc();
        int price3=getLatestPriceofusdt();

        //Hence 1 matic= price of matic at the moment/price of usdc at that moment
        //Similary 1 matic=price of matic at the moment/ price of usdc at the moment

        //But these calculations are kept for the frontend
    }
}