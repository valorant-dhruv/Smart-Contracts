// SPDX-License-Identifier: BUSL-1.1
pragma solidity =0.7.6;

// import 'https://github.com/Uniswap/v3-core/blob/main/contracts/UniswapV3PoolDeployer.sol';
// import 'https://github.com/Uniswap/v3-core/blob/main/contracts/NoDelegateCall.sol';
import 'https://github.com/Uniswap/v3-core/blob/main/contracts/UniswapV3Pool.sol';

// interface IUniswapV3Factory {
//     event OwnerChanged(address indexed oldOwner, address indexed newOwner);

//     event PoolCreated(
//         address indexed token0,
//         address indexed token1,
//         uint24 indexed fee,
//         int24 tickSpacing,
//         address pool
//     );


//     function getPool(
//         address tokenA,
//         address tokenB,
//         uint24 fee
//     ) external view returns (address pool);

   
//     function createPool(
//         address tokenA,
//         address tokenB,
//         uint24 fee
//     ) external returns (address pool);

    
// }

// interface IUniswapV3PoolDeployer {
//     /// @notice Get the parameters to be used in constructing the pool, set transiently during pool creation.
//     /// @dev Called by the pool constructor to fetch the parameters of the pool
//     /// Returns factory The factory address
//     /// Returns token0 The first token of the pool by address sort order
//     /// Returns token1 The second token of the pool by address sort order
//     /// Returns fee The fee collected upon every swap in the pool, denominated in hundredths of a bip
//     /// Returns tickSpacing The minimum number of ticks between initialized ticks
//     function parameters()
//         external
//         view
//         returns (
//             address factory,
//             address token0,
//             address token1,
//             uint24 fee,
//             int24 tickSpacing
//         );
// }

contract UniswapV3PoolDeployer is IUniswapV3PoolDeployer {
    struct Parameters {
        address factory;
        address token0;
        address token1;
        uint24 fee;
        int24 tickSpacing;
    }

    /// @inheritdoc IUniswapV3PoolDeployer
    Parameters public override parameters;

    /// @dev Deploys a pool with the given parameters by transiently setting the parameters storage slot and then
    /// clearing it after deploying the pool.
    /// @param factory The contract address of the Uniswap V3 factory
    /// @param token0 The first token of the pool by address sort order
    /// @param token1 The second token of the pool by address sort order
    /// @param fee The fee collected upon every swap in the pool, denominated in hundredths of a bip
    /// @param tickSpacing The spacing between usable ticks
    function deploy(
        address factory,
        address token0,
        address token1,
        uint24 fee,
        int24 tickSpacing
    ) internal returns (address pool) {
        parameters = Parameters({factory: factory, token0: token0, token1: token1, fee: fee, tickSpacing: tickSpacing});
        pool = address(new UniswapV3Pool{salt: keccak256(abi.encode(token0, token1, fee))}());
        delete parameters;
    }
}

contract UniswapV3Factory is IUniswapV3Factory, UniswapV3PoolDeployer, NoDelegateCall {
    /// @inheritdoc IUniswapV3Factory
    address public override owner;

    /// @inheritdoc IUniswapV3Factory
    mapping(uint24 => int24) public override feeAmountTickSpacing;
    /// @inheritdoc IUniswapV3Factory
    mapping(address => mapping(address => mapping(uint24 => address))) public override getPool;

    constructor() {
        owner = msg.sender;
        emit OwnerChanged(address(0), msg.sender);

        feeAmountTickSpacing[500] = 10;
        emit FeeAmountEnabled(500, 10);
        feeAmountTickSpacing[3000] = 60;
        emit FeeAmountEnabled(3000, 60);
        feeAmountTickSpacing[10000] = 200;
        emit FeeAmountEnabled(10000, 200);
    }

    /// @inheritdoc IUniswapV3Factory
    function createPool(
        address tokenA,
        address tokenB,
        uint24 fee
    ) external override noDelegateCall returns (address pool) {
        require(tokenA != tokenB);
        (address token0, address token1) = tokenA < tokenB ? (tokenA, tokenB) : (tokenB, tokenA);
        require(token0 != address(0));
        int24 tickSpacing = feeAmountTickSpacing[fee];
        require(tickSpacing != 0);
        require(getPool[token0][token1][fee] == address(0));
        pool = deploy(address(this), token0, token1, fee, tickSpacing);
        getPool[token0][token1][fee] = pool;
        // populate mapping in the reverse direction, deliberate choice to avoid the cost of comparing addresses
        getPool[token1][token0][fee] = pool;
        emit PoolCreated(token0, token1, fee, tickSpacing, pool);
    }

    /// @inheritdoc IUniswapV3Factory
    function setOwner(address _owner) external override {
        require(msg.sender == owner);
        emit OwnerChanged(owner, _owner);
        owner = _owner;
    }

    /// @inheritdoc IUniswapV3Factory
    function enableFeeAmount(uint24 fee, int24 tickSpacing) public override {
        require(msg.sender == owner);
        require(fee < 1000000);
        // tick spacing is capped at 16384 to prevent the situation where tickSpacing is so large that
        // TickBitmap#nextInitializedTickWithinOneWord overflows int24 container from a valid tick
        // 16384 ticks represents a >5x price change with ticks of 1 bips
        require(tickSpacing > 0 && tickSpacing < 16384);
        require(feeAmountTickSpacing[fee] == 0);

        

        feeAmountTickSpacing[fee] = tickSpacing;
        emit FeeAmountEnabled(fee, tickSpacing);
    }
}