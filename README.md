# DEFI-WEB3EG
# $${\color{green}Day 01}$$	

## 1- Create Token WEB3EG Using Openzeppelin 

Install Dependencies
```solidity

forge install OpenZeppelin/openzeppelin-contracts@v4.9.3 --no-commit
forge install uniswap/v2-core --no-commit
forge install uniswap/v2-periphery --no-commit

```

```solidity
// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import "@openzeppelin/contracts/access/Ownable.sol";

contract Web3EG is ERC20, Ownable {
    constructor() ERC20("Web3 Egypt", "WEB3EG") {
        _mint(msg.sender, 1000000 ether);
//1_000_000 * 10 ** 18 = 1000000000000000000000000

    }
}
```
## 2- Write Script to Deploy on Sepolia with Foundry FrameWork
```solidity
//SPDX-License-Identifier:UNLICENSED
pragma solidity ^0.8.20;
import "forge-std/Script.sol";
import "forge-std/console.sol";
import "src/Web3eg.sol";

contract DeployWeb3eg is Script {

    function run() external{
        vm.startBroadcast();

        Web3eg web3eg = new Web3eg();
        console.log("web3eg deploy at address:",address(web3eg));

        vm.stopBroadcast();

    }
}
```
Command line to Deploy on Sepolia
```
 forge script script/DeployWeb3eg.s.sol:DeployWeb3eg --rpc-url https://sepolia.infura.io/v3/"YOUR_API_KEY" --private-key "your private key" --broadcast
```
## 3- Deploy on Fork Ethereum mainnet


- Run anvil with fork
```
anvil --fork-url https://eth-mainnet.g.alchemy.com/v2/YOUR_API_KEY
```
- Select block
```
anvil --fork-url https://eth-mainnet.g.alchemy.com/v2/YOUR_API_KEY --fork-block-number 15969633
```
- Script to run
  
```  
forge script script/DeployWeb3eg.s.sol:DeployWeb3eg --fork-url http://127.0.0.1:8545
  --fork-block-number 22269552
 --private-key "your private key" --broadcast
```


--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------


# $${\color{green}Day 02}$$	

## 1- Install Dependencies: Your contracts use OpenZeppelin and Uniswap V2 libraries
```solidity
forge install OpenZeppelin/openzeppelin-contracts@v4.9.3 --no-commit
forge install uniswap/v2-core --no-commit
forge install uniswap/v2-periphery --no-commit
```
## 2- Web3eg Token and mint 1000000 Token
```solidity
//SPDX-License-Identifier:UNLICENSED
pragma solidity ^0.8.13;
import {ERC20} from "lib/openzepplin-contracts/contracts/token/ERC20/ERC20.sol";

contract Web3eg is ERC20  {
    constructor() ERC20("web3eg","EG"){

        _mint(msg.sender , 1_000_000 ether);

    }
}

```
## 3- Web3egDex smart contract to interact MyToken to uinswap AddLiquidity
```solidity
//SPDX-License-Identifier: MIT
pragma solidity ^0.8.23;
import "lib/openzepplin-contracts/contracts/token/ERC20/ERC20.sol";
import "lib/v2-core/contracts/interfaces/IUniswapV2Factory.sol";
import "lib/v2-core/contracts/interfaces/IUniswapV2Pair.sol";
import "lib/v2-periphery/contracts/interfaces/IUniswapV2Router02.sol";
import "src/Web3eg.sol";


contract Web3egDex{

// contract which intract with uniswap v2 router and factory
address public owner;
IUniswapV2Router02 public router;
IUniswapV2Factory public factory;
Web3eg public MyToken;
address public pair;
address public WETH;

constructor(address _router, address _MyToken){
    owner = msg.sender;
    router = IUniswapV2Router02(_router);
    MyToken = Web3eg(_MyToken);
    factory = IUniswapV2Factory(router.factory());
    WETH = router.WETH();
    pair = factory.createPair(address(MyToken), WETH);
}

modifier ownlyOwner() { require(owner == msg.sender, "you are not owner");
_; 
}

function addLiquidity(uint256 tokenAmount, uint256 ethAmount) external ownlyOwner {
    MyToken.approve(address(router), tokenAmount);
    router.addLiquidityETH{value: ethAmount}(
        address(MyToken),
        tokenAmount,
        0,
        0,
        address(this),
        block.timestamp
    );
    

}
receive() external payable{}
}

```
## 4- script to deploy on fork ethereum maimnet

```solidity
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
```
## 5- command to run and deploy 
```
// new terminal run 
anvil --fork-url https://mainnet.infura.io/v3/733106f2f15a458183c1c442993ddc3f

forge script script/DeployWeb3eg.s.sol:Deploy --fork-url http:/127.0.0.1:8545 --private-key <your private key> --broadcast
```

----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

# $${\color{green}Day 03}$$	


 




