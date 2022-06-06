//SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

//can hold multiple contracts in one file
import "./SimpleStorage.sol"; //importing other contracts

contract StorageFactory {

    SimpleStorage[] public simpleStorageArray;

    function createSimpleStorageContract() public {
        SimpleStorage simpleStorage = new SimpleStorage();
        simpleStorageArray.push(simpleStorage);
    }

    //storageFactory store
    //needs Address and ABI to interact with contract
    function sfStore(uint256 _simpleStorageIndex, uint256 _simpleStorageNumber) public {
        //get address and get simpleStorage object at that index
        simpleStorageArray[_simpleStorageIndex].store(_simpleStorageNumber);
    }

    //read from storageFactory
    function sfGet(uint256 _simpleStorageIndex) public view returns(uint256){
        return simpleStorageArray[_simpleStorageIndex].retrieve();
    }
}
