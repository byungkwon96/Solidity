// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract FallbackExample {
    uint256 public result;

    //triggers anytime there is no function is called without data 
    receive() external payable {
        result = 1;
    }
    //triggers anytime there is no function but there is data
    fallback() external payable {
        result = 2;
    }
}
