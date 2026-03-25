// SPDX-License-Identifier: MIT
pragma solidity ^0.8.25;

import "forge-std/Script.sol";
import { BuyMeACoffee } from "../src/Coffee.sol";
import { console } from "forge-std/console.sol";

contract DeployCoffee is Script {
    function run() external {
        uint256 deployerPrivateKey = vm.envUint("PRIVATE_KEY");
        address artist = vm.addr(deployerPrivateKey);

        vm.startBroadcast(deployerPrivateKey);

        BuyMeACoffee coffee = new BuyMeACoffee(
            artist,
            "Bhavishya Jain"
        );

        console.log("Contract deployed at:", address(coffee));

        vm.stopBroadcast();
    }
}
