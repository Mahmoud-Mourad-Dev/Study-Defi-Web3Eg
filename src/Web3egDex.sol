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

