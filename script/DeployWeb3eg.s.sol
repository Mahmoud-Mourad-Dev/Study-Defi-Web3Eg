// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.23;

import "forge-std/Script.sol";
import "../src/Web3eg.sol";
import "../src/Web3egDex.sol";

contract Deploy is Script {
    function run() external {
        vm.startBroadcast();
       

        // Deploy the Web3eg token contract
        Web3eg token = new Web3eg();
        console.log("Web3eg Token deployed at:", address(token));

        // Uniswap V2 Router address (mainnet)
        address uniswapRouter = 0x7a250d5630B4cF539739dF2C5dAcb4c659F2488D;

        // Deploy the Web3egDex contract
        Web3egDex dex = new Web3egDex(uniswapRouter, address(token));
        console.log("Web3egDex deployed at:", address(dex));

        // Stop broadcasting
        vm.stopBroadcast();
    }
}