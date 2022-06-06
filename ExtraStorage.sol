// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

//inheritence - child contract of simple storage
import "./SimpleStorage.sol";
//is-keyword inheriet everything of SimpleStorage
contract ExtraStorage is SimpleStorage{
    //override, virtual
    //if parents contract have same funciton use override
    //needs virtual keyword in parents method so child functions can overide
    function store(uint256 _favoriteNumber) public override{
        favoriteNumber = _favoriteNumber;
    }
}
