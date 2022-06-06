// SPDX-License-Identifier: MIT

pragma solidity ^0.8.8; //^ above works, >=0.8.7 <0.8.9

//contract is keyword of contract
contract SimpleStorage {
    //types: boolean, uint, int, address, bytes, string
    //bool hasFavoriteNumber = true;
    //uint256 favoriteNumber = 123;
    //int256 favoriteInt = -5;
    //string favortieNumberInText = "Five"
    //address myAddress = 0x13860199573bceb793eFeC0f85eD91dd0E4433F0;
    //bytes32 favoriteBytes = "cat"

    //if you don;t assign value it automatically choose null value which is 0
    uint256 favoriteNumber; //visibility default is private 
    //public is visible externally and internally
    //private only visibile in contract other external - visiblie externally, internal - only in contract or derived contract
    People public person = People({favoriteNumber: 2, name: "Tom"});

    //map name to favorite number
    mapping(string => uint256) public nameToFavoriteNumber;

    struct People {
        uint256 favoriteNumber;
        string name;
    }

    //array notation in solidity (dynamic array [], or max_size array[3])
    People[] public people;

    // "_f.." use _ in the paramter to distinguish between different variables. 
    // more stuff in your fucntion more gas fees
    function store(uint256 _favoriteNumber) public {
        favoriteNumber = _favoriteNumber;
        favoriteNumber = favoriteNumber + 1;
    }

    //view (read state), pure(can't read nore modify) don't need any gas
    function retrieve() public view returns(uint256){
        return favoriteNumber;
    }

    //function to add person to people array
    //6 places to store, stack, memory , storage, calldata, code, logs
    // calldata, memory - only exist temperoary during the transaction
    // calldata - can't change the data, memory can modified within the function
    // storage - exists even after the transaction
    function addPerson(string memory _name, uint256 _favoriteNumber) public {
        people.push(People(_favoriteNumber,_name));
        nameToFavoriteNumber[_name] = _favoriteNumber; //map string to number
    }
}

//0xd9145CCE52D386f254917e481eB44e9943F39138
