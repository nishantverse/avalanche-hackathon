    //SPDX-License-Identifier:MIT
    pragma solidity ^0.8.25;


contract BuyMeACoffee{
    address public artist;
    string public artistName;
    uint256 public numberOfCoffees;
    struct Coffeesbought {
        string name;
        string message;
    }
    Coffeesbought[] public allCoffees;

    error notArtist();
    error amountCannotBeZero();
    error buyingCoffeeFailed();


    event buyedCoffeeSuccessfully(address indexed from, string name, string message);
    event withdrawCoffeeSuccessfullly(address indexed to, uint amount);

    modifier onlyArtist{
        if(msg.sender != artist){
            revert notArtist();
        }
        _;
    }
    constructor(address artistAddress, string memory name){
        artist = artistAddress;
        artistName = name;
    }

    function buyCoffee(string memory name, string memory message) external payable{
        if(msg.value <= 0){
            revert amountCannotBeZero();
        }
        Coffeesbought memory newCoffee = Coffeesbought(name, message);
        allCoffees.push(newCoffee);
        numberOfCoffees++;
        emit buyedCoffeeSuccessfully(msg.sender, name, message);
    }
    
    function withdrawCoffee() external onlyArtist{
        uint amount = address(this).balance;
        (bool success, ) = artist.call{value: amount}("");
        if(!success){
            revert buyingCoffeeFailed();
        }
        emit withdrawCoffeeSuccessfullly(artist, amount);
    }

    function getBalance() external view onlyArtist returns (uint256){
        return address(this).balance;
    }

    function getAllCoffees() external view returns (Coffeesbought[] memory){
        return allCoffees;
    }
}