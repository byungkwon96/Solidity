//Get funds from the users
//Withdraw funds
//Set a minimum funding value in USD

//SPDX-License-Identifier: MIT
pragma solidity ^0.8.8;

import "./PriceConverter.sol";

error NotOwner();

//constant immutable can reduce the gas
contract FundMe {

    //getConversionRate(msg.value) === msg.value.getConversionRate()
    using PriceConverter for uint256; 

    //assign compile time use constant keyword
    uint256 public constant MINIMUM_USD = 50 * 1e18;

    address[] public funders;
    mapping(address => uint256) public addressToAmountFunded;

    //if variable gets sets one time use gas efficient method
    address public immutable i_owner;

    //runs right after contract gets deployed
    constructor(){
        i_owner = msg.sender;
    }

    //get funds function
    //transaction has fields: Nonce, gasprice, gas limit, to, value, data, (v,r,s)
    //value transfer - gaslimit: 21000, to - address, data-empty
    //funciton call - to: address, data
    //payable - contracts address can hold funds 
    function fund() public payable{
        //undo anything thats get reverted and give back remaining gas
        require(msg.value.getConversionRate() >= MINIMUM_USD, "Didn't send enough"); //1e18 == 1*10^18 
        //msg.sender address of caller, msg.value - 
        funders.push(msg.sender);
        addressToAmountFunded[msg.sender] += msg.value;
    }

    //can put modifier at the end of the function
    function withdraw() public onlyOwner{
        //for loop and reset array
        for(uint256 fundersIndex = 0; fundersIndex < funders.length; fundersIndex++){
            address funder = funders[fundersIndex];
            addressToAmountFunded[funder] = 0;
        }
        //reset the array
        funders = new address[](0);

        //withdraw the funds (3 ways): transfer send call
        //1.transfer - cast address to payable address (automatically revert)
        //payable(msg.sender).transfer(address(this).balance);

        //2.send - don't revert needs to check with require 
        //bool sendSuccess = payable(msg.sender).send(address(this).balance);
        //require(sendSuccess, "Send failed");

        //3.call - can use without an abi (returns 2 value)
        (bool callSuccess, /*bytes memory dataReturned*/) = payable(msg.sender).call{value: address(this).balance}("");
        require(callSuccess , "Call failed");

    }

    //modifier runs before or after the function
    modifier onlyOwner{
        if(msg.sender != i_owner) {revert NotOwner();} //gas-effcient
        //require(msg.sender == i_owner, "Sender is not owner");
        //do the rest of the code
        _;
    }

    // What happens if someone sends this contract ETH without using fund function
    // receive()
    receive() external payable {
        fund();
    }
    fallback() external payable {
        fund();
    }
}
