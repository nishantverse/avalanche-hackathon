//SPDX-License-Identiifier:MIT
pragma solidity ^0.8.25;

import { BuyMeACoffee } from "./coffee.sol";

contract CoffeeFactory{
    mapping(address => BuyMeACoffee) public contracts;
    address[] public contractAddresses;

    error alreadyDeployed();

    event coffeeContractDeployed(address indexed artist, address indexed contractAddress);

    function createCoffeeContract(string memory name) external {
        if (address(contracts[msg.sender]) != address(0)) {
            revert alreadyDeployed();
        }
        BuyMeACoffee coffeeFactory = new BuyMeACoffee(msg.sender, name);
        contracts[msg.sender] = coffeeFactory;
        contractAddresses.push(address(coffeeFactory));
        emit coffeeContractDeployed(msg.sender, address(coffeeFactory)); 
    }

    function getAllContracts() external view returns (address[] memory){
        return contractAddresses;
    }
}