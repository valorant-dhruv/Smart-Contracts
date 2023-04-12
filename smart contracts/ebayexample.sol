//SPDX-License-Identifier:MIT

pragma solidity >=0.5.0 <0.9.0;

contract Ebay{
    //This is the structure for registering the product by the seller
    struct Product{
        string name;
        uint price;
        address seller;  
    }

    address private delivery;

    //This is the constructor which assigns the value of the delivery to some account address
    constructor(address _delivery)
    {
        delivery=_delivery;
    }

    //These are the events that are triggered when all the operations of the function are executed successfully.
    event ProductRegistered(address indexed seller,string name, uint price,uint productId);
    event Shipproduct(address indexed seller,address indexed buyer,uint sellprice,uint productId);


    uint private productId=0;

    mapping(uint=>Product) public sellers;
    mapping(uint=>bool) public sold;

    function registerproduct(string memory _name,uint _price) external payable returns(bool)
    {
        //The seller will have to pay some amount of ethers in case the seller doesn't deliver the product
        require(_price==msg.value,"The deposit amount must be same as the price of the product");

        Product memory product;
        product.name=_name;
        product.price=_price;
        product.seller=msg.sender;

        sellers[productId]=product;

        emit ProductRegistered(msg.sender,_name,_price,productId);

        productId+=1;

        return true;

    }

    //This is the modifier which indicates that the function can only be called by the delivery address
    modifier deliveryonly()
    {
        require(msg.sender==delivery,"Only the delivery agent can call this function");
        _;
    }

    //This function is just reading contents from the smart contract
    //Hence this function as it is not changing the state variables will not require any gas fees
    function getproductdetail(uint _productId) external view returns(Product memory)
    {
        return sellers[_productId];
    }

    //Now this is the buy function
    function buy(uint _productId,uint buyprice) external payable returns(bool)
    {
        require(msg.value==sellers[_productId].price,"The asking price must match the selling price");
        require(buyprice==msg.value,"The buying price must be same as the ethers that you are sending");

        if(sold[_productId])
        {
            //This means that the product has already been sold and hence there is no reason to buy the product
            payable(msg.sender).transfer(buyprice);
            revert("The product has already been bought");
        }

        Product memory product=sellers[productId];

        sold[_productId]=true;

        //This means that the product is not yet sold and hence can be bought
        emit Shipproduct(product.seller,msg.sender,buyprice,_productId);
        return true;
    }

    //This function returns the balance of the smart contract
    function returnbalance() external view returns(uint)
    {
        return address(this).balance;
    }


    function deliverydone(uint _productId) external deliveryonly{
        //This means that the delivery is completed and hence the smart contract now needs to transfer the deposit back
        address seller=sellers[_productId].seller;
        payable(seller).transfer(sellers[_productId].price+sellers[_productId].price);

    }
}