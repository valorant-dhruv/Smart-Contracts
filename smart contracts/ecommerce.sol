//SPDX-License-Identifier:UNLICENSED

pragma solidity >=0.5.0 <0.9.0;

contract Ecommerce{
    
    //This is the structure of the product
    struct Product{
        string title;
        string desc;
        uint price;
        address payable seller;
        address buyer;
        uint productId;
        bool delivered;
    }
    //The count variable
    uint public count=1;

    //Now we create a array of these Product
    Product[] public products;

    //This is the address of the manager
    address payable public manager;

   //A constructor to assign the address of the manager
    constructor()
    {
        manager=payable(msg.sender);
    }

    bool destroyed=false;
    modifier isNotDestroyed{ 
        require(!destroyed,"Contract does not exist"); 
        _; 
    }

    // //The destroy function
    // function destroy() public isNotDestroyed{
    //     //We need to see whether only the manager is calling the destroy function or not
    //     require(manager==msg.sender,"Only manager is allowed to destroy");
    //     selfdestruct(manager);
    // }

    //The destroy function is now slightly changed
    //We also have a fallback function that transfers the ethers back to the buyer if the buyer sends some ether when 
    //the contract is destroyed
    //This destroy function is used when the contract has been compromised and in that case the manager calls the function
    //and transfers all the contract ethers to the manager
    function destroy() public isNotDestroyed{ 
        require(manager==msg.sender,"only manager can call this");
         manager.transfer(address(this).balance); destroyed=true;
         }

    fallback() payable external{ 
        payable(msg.sender).transfer(msg.value); 
        } 

    //The events
    event registered(string title,string desc,uint price,address seller);
    event bought(uint productId,address buyer);
    event delivered(uint productId,address buyer,address seller);

    //The register function 
    function registerProduct(string memory _title,string memory _desc,uint _price) public isNotDestroyed
    {
        //We need to check if the price is greater than 0 or not
        require(_price>0,"The price cannot be less than zero");

        Product memory tempproduct;
        tempproduct.title=_title;
        tempproduct.desc=_desc;
        tempproduct.price=_price*10**18;
        tempproduct.seller=payable(msg.sender);
        tempproduct.productId=count;

        //Now as the tempproduct is created and its attributes are assigned we push the tempproduct into the products array
        products.push(tempproduct);
        count++;

        emit registered(_title,_desc,_price,tempproduct.seller);
    }

    //The buy function
    function buy(uint _productId) payable public isNotDestroyed{

        //We need to check whether the buyer price is equal to the product price
        require(msg.value==products[_productId-1].price,"Please pay the exact price");

        //We also need to check whether the seller is not the buyer of the product
        require(msg.sender!=products[_productId-1].seller,"The buyer cannot be the seller of the product");

        products[_productId-1].buyer=msg.sender;

        emit bought(_productId,products[_productId-1].buyer);
    }

    //The delivery function
    function delivery(uint _productId) public isNotDestroyed{

        //We need to check whether the buyer of the product is confirming the delivery or not
        require(products[_productId-1].buyer==msg.sender,"Only the buyer of the product can confirm");

        products[_productId-1].delivered=true;

        emit delivered(_productId,products[_productId-1].buyer,products[_productId-1].seller);
    }

    //The transfer function
    function transfer(uint _productId) public isNotDestroyed{
        //We need to check whether the product is delivered before transfering the ethers.
        require(products[_productId-1].delivered==true,"The product must be delivered before the money can be transfered");

        products[_productId-1].seller.transfer(products[_productId-1].price);
    }
}
