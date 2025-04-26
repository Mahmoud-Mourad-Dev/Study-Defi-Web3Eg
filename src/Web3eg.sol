//SPDX-License-Identifier:UNLICENSED
pragma solidity ^0.8.13;
import {ERC20} from "lib/openzepplin-contracts/contracts/token/ERC20/ERC20.sol";

contract Web3eg is ERC20  {
    constructor() ERC20("web3eg","EG"){

        _mint(msg.sender , 1_000_000 ether);

    }
}

