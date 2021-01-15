/**
 *Submitted for verification at Etherscan.io on 2020-06-05
*/
// SPDX-License-Identifier: GPL-3.0
pragma solidity >=0.8.0;

interface IUniswapV2Factory {

    event PairCreated(address indexed token0, address indexed token1, address pair, uint);

    function feeTo() external view returns (address);
    function feeToSetter() external view returns (address);

    function getPair(address tokenA, address tokenB) external view returns (address pair);
    function allPairs(uint) external view returns (address pair);
    function allPairsLength() external view returns (uint);

    function createPair(address tokenA, address tokenB) external returns (address pair);

    function setFeeTo(address) external;
    function setFeeToSetter(address) external;
}

interface IUniswapV2Pair {
    event Approval(address indexed owner, address indexed spender, uint value);
    event Transfer(address indexed from, address indexed to, uint value);

    function name() external pure returns (string memory);
    function symbol() external pure returns (string memory);
    function decimals() external pure returns (uint8);
    function totalSupply() external view returns (uint);
    function balanceOf(address owner) external view returns (uint);
    function allowance(address owner, address spender) external view returns (uint);

    function approve(address spender, uint value) external returns (bool);
    function transfer(address to, uint value) external returns (bool);
    function transferFrom(address from, address to, uint value) external returns (bool);

    function DOMAIN_SEPARATOR() external view returns (bytes32);
    function PERMIT_TYPEHASH() external pure returns (bytes32);
    function nonces(address owner) external view returns (uint);

    function permit(address owner, address spender, uint value, uint deadline, uint8 v, bytes32 r, bytes32 s) external;

    event Mint(address indexed sender, uint amount0, uint amount1);
    event Burn(address indexed sender, uint amount0, uint amount1, address indexed to);
    event Swap(
        address indexed sender,
        uint amount0In,
        uint amount1In,
        uint amount0Out,
        uint amount1Out,
        address indexed to
    );
    event Sync(uint112 reserve0, uint112 reserve1);

    function MINIMUM_LIQUIDITY() external pure returns (uint);
    function factory() external view returns (address);
    function token0() external view returns (address);
    function token1() external view returns (address);
    function getReserves() external view returns (uint112 reserve0, uint112 reserve1, uint32 blockTimestampLast);
    function price0CumulativeLast() external view returns (uint);
    function price1CumulativeLast() external view returns (uint);
    function kLast() external view returns (uint);

    function mint(address to) external returns (uint liquidity);
    function burn(address to) external returns (uint amount0, uint amount1);
    function swap(uint amount0Out, uint amount1Out, address to, bytes calldata data) external;
    function skim(address to) external;
    function sync() external;

    function initialize(address, address) external;
}

interface IUniswapV2Router01 {
    function factory() external view returns (address);
    function WETH() external view returns (address);

    function addLiquidity(
        address tokenA,
        address tokenB,
        uint amountADesired,
        uint amountBDesired,
        uint amountAMin,
        uint amountBMin,
        address to,
        uint deadline
    ) external returns (uint amountA, uint amountB, uint liquidity);
    function addLiquidityETH(
        address token,
        uint amountTokenDesired,
        uint amountTokenMin,
        uint amountETHMin,
        address to,
        uint deadline
    ) external payable returns (uint amountToken, uint amountETH, uint liquidity);
    function removeLiquidity(
        address tokenA,
        address tokenB,
        uint liquidity,
        uint amountAMin,
        uint amountBMin,
        address to,
        uint deadline
    ) external returns (uint amountA, uint amountB);
    function removeLiquidityETH(
        address token,
        uint liquidity,
        uint amountTokenMin,
        uint amountETHMin,
        address to,
        uint deadline
    ) external returns (uint amountToken, uint amountETH);
    function removeLiquidityWithPermit(
        address tokenA,
        address tokenB,
        uint liquidity,
        uint amountAMin,
        uint amountBMin,
        address to,
        uint deadline,
        bool approveMax, uint8 v, bytes32 r, bytes32 s
    ) external returns (uint amountA, uint amountB);
    function removeLiquidityETHWithPermit(
        address token,
        uint liquidity,
        uint amountTokenMin,
        uint amountETHMin,
        address to,
        uint deadline,
        bool approveMax, uint8 v, bytes32 r, bytes32 s
    ) external returns (uint amountToken, uint amountETH);
    function swapExactTokensForTokens(
        uint amountIn,
        uint amountOutMin,
        address[] calldata path,
        address to,
        uint deadline
    ) external returns (uint[] memory amounts);
    function swapTokensForExactTokens(
        uint amountOut,
        uint amountInMax,
        address[] calldata path,
        address to,
        uint deadline
    ) external returns (uint[] memory amounts);
    function swapExactETHForTokens(uint amountOutMin, address[] calldata path, address to, uint deadline)
    external
    payable
    returns (uint[] memory amounts);
    function swapTokensForExactETH(uint amountOut, uint amountInMax, address[] calldata path, address to, uint deadline)
    external
    returns (uint[] memory amounts);
    function swapExactTokensForETH(uint amountIn, uint amountOutMin, address[] calldata path, address to, uint deadline)
    external
    returns (uint[] memory amounts);
    function swapETHForExactTokens(uint amountOut, address[] calldata path, address to, uint deadline)
    external
    payable
    returns (uint[] memory amounts);

    function quote(uint amountA, uint reserveA, uint reserveB) external pure returns (uint amountB);
    function getAmountOut(uint amountIn, uint reserveIn, uint reserveOut) external pure returns (uint amountOut);
    function getAmountIn(uint amountOut, uint reserveIn, uint reserveOut) external pure returns (uint amountIn);
    function getAmountsOut(uint amountIn, address[] calldata path) external view returns (uint[] memory amounts);
    function getAmountsIn(uint amountOut, address[] calldata path) external view returns (uint[] memory amounts);
}

interface IUniswapV2Router02 is IUniswapV2Router01 {
    function removeLiquidityETHSupportingFeeOnTransferTokens(
        address token,
        uint liquidity,
        uint amountTokenMin,
        uint amountETHMin,
        address to,
        uint deadline
    ) external returns (uint amountETH);
    function removeLiquidityETHWithPermitSupportingFeeOnTransferTokens(
        address token,
        uint liquidity,
        uint amountTokenMin,
        uint amountETHMin,
        address to,
        uint deadline,
        bool approveMax, uint8 v, bytes32 r, bytes32 s
    ) external returns (uint amountETH);

    function swapExactTokensForTokensSupportingFeeOnTransferTokens(
        uint amountIn,
        uint amountOutMin,
        address[] calldata path,
        address to,
        uint deadline
    ) external;
    function swapExactETHForTokensSupportingFeeOnTransferTokens(
        uint amountOutMin,
        address[] calldata path,
        address to,
        uint deadline
    ) external payable;
    function swapExactTokensForETHSupportingFeeOnTransferTokens(
        uint amountIn,
        uint amountOutMin,
        address[] calldata path,
        address to,
        uint deadline
    ) external;
}

interface IERC20 {
    event Approval(address indexed owner, address indexed spender, uint value);
    event Transfer(address indexed from, address indexed to, uint value);

    function name() external view returns (string memory);
    function symbol() external view returns (string memory);
    function decimals() external view returns (uint8);
    function totalSupply() external view returns (uint);
    function balanceOf(address owner) external view returns (uint);
    function allowance(address owner, address spender) external view returns (uint);

    function approve(address spender, uint value) external returns (bool);
    function transfer(address to, uint value) external returns (bool);
    function transferFrom(address from, address to, uint value) external returns (bool);
}

interface IWETH {
    function deposit() external payable;
    function transfer(address to, uint value) external returns (bool);
    function withdraw(uint) external;
}

contract UniswapV2Router02 is IUniswapV2Router02 {
    using SafeMath for uint;
    //address public override immutable factory;   // override
    //address public override immutable  WETH;     // override
    address public override immutable factory;   // override
    address public override immutable WETH;     // override

    // 修饰符：确保当前时间小于最后期限
    modifier ensure(uint deadline) {
        require(deadline >= block.timestamp, 'UniswapV2Router: EXPIRED');
        _;
    }

    // 构造函数：传入工厂地址和WETH地址
    constructor(address _factory, address _WETH) {
        factory = _factory;
        WETH = _WETH;
    }

    // 退款方法
    receive() external payable {
        // 断言调用者为weth合约地址
        assert(msg.sender == WETH);                 // only accept ETH via fallback from the WETH contract
    }

    // **** ADD LIQUIDITY ****
    // 添加流动性的私有方法
    function _addLiquidity(
        address tokenA,            // tA地址
        address tokenB,            // tB地址
        uint amountADesired,       // 期望数额A
        uint amountBDesired,       // 期望数额B
        uint amountAMin,           // 最小数额A
        uint amountBMin            // 最小数额B
    ) internal virtual returns (uint amountA, uint amountB) {
        // create the pair if it doesn't exist yet
        // 如果配对不存在，则创建该对
        if (IUniswapV2Factory(factory).getPair(tokenA, tokenB) == address(0)) {
            // 调用工厂合约的创建配对方法
            IUniswapV2Factory(factory).createPair(tokenA, tokenB);
        }

        // 获取储备量reserve{A,B}
        (uint reserveA, uint reserveB) = UniswapV2Library.getReserves(factory, tokenA, tokenB);

        if (reserveA == 0 && reserveB == 0) {
            // 这种情况是这个配对合约刚刚被创建处理，流动池里面没有其它数额
            // 所以 数值 = 期望的数值
            (amountA, amountB) = (amountADesired, amountBDesired);
        } else {
            // 数量B的最优解 = 期望A / 储备A * 储备B  (根据比例算B的份额)
            uint amountBOptimal = UniswapV2Library.quote(amountADesired, reserveA, reserveB);

            // 如果B的最优解是小等于输入的期望值，则表示当前计算有效
            if (amountBOptimal <= amountBDesired) {
                // 确保B的最优解大等于B的最小值
                require(amountBOptimal >= amountBMin, 'UniswapV2Router: INSUFFICIENT_B_AMOUNT');
                // 返回  A的期望值，B的最优解
                (amountA, amountB) = (amountADesired, amountBOptimal);
            } else {
                // 计算A的最优解
                uint amountAOptimal = UniswapV2Library.quote(amountBDesired, reserveB, reserveA);
                // 断言A的最优解小等于A的期望值
                assert(amountAOptimal <= amountADesired);
                // 确保返回的A的数值大等于A的最小值
                require(amountAOptimal >= amountAMin, 'UniswapV2Router: INSUFFICIENT_A_AMOUNT');
                // 返回  A的最优解，B的期望值
                (amountA, amountB) = (amountAOptimal, amountBDesired);
            }
        }
    }

    // 外部调用的添加流动性数值的方法（token 对 token）
    function addLiquidity(
        address tokenA,                   // tokenA地址
        address tokenB,                   // tokenB地址
        uint amountADesired,              // tokenA的期望数额
        uint amountBDesired,              // tokenB的期望数额
        uint amountAMin,                  // A的最小数额
        uint amountBMin,                  // B的最小数额
        address to,                       // 获得流动性数额的地址
        uint deadline                     // 最大期限时间
    ) external virtual override ensure(deadline) returns (uint amountA, uint amountB, uint liquidity) {

        // 调用内部的添加流动性方法得到计算之后的数值A和数值B
        (amountA, amountB) = _addLiquidity(tokenA, tokenB, amountADesired, amountBDesired, amountAMin, amountBMin);

        // 根据工厂地址，tokenA，tokenB得到pair合约地址
        address pair = UniswapV2Library.pairFor(factory, tokenA, tokenB);

        // 将amount数额的token发送给pair合约地址
        TransferHelper.safeTransferFrom(tokenA, msg.sender, pair, amountA);
        TransferHelper.safeTransferFrom(tokenB, msg.sender, pair, amountB);
        // 调用pair合约的铸造方法，得到计算过后的流动性数额
        liquidity = IUniswapV2Pair(pair).mint(to);
    }

    // 添加流动性（token 对 ETH）
    function addLiquidityETH(
        address token,                     // token地址
        uint amountTokenDesired,           // token期望数额
        uint amountTokenMin,               // token最小数额
        uint amountETHMin,                 // ETH最小数额
        address to,                        // to地址
        uint deadline                      // 最大过期时间
    ) external virtual override payable ensure(deadline) returns (uint amountToken, uint amountETH, uint liquidity) {
        // 调用内部方法计算得到（token数额，ETH数额）
        (amountToken, amountETH) = _addLiquidity(
            token,                         // token地址
            WETH,                          // ETH地址
            amountTokenDesired,            // token期望数额
            msg.value,                     // ETH期望数额（当前主币收到的数额）
            amountTokenMin,                // tokne最小数额
            amountETHMin                   // ETH最小数额
        );

        // 根据token和ETH得到pair合约地址
        address pair = UniswapV2Library.pairFor(factory, token, WETH);

        // 将计算得到的token数额从token中发送到pair合约地址中
        TransferHelper.safeTransferFrom(token, msg.sender, pair, amountToken);

        // 向WETH合约中存款amountETH数量的主币
        IWETH(WETH).deposit{value: amountETH}();
        // 将amountETH数量的WETH发送给pair合约地址中
        assert(IWETH(WETH).transfer(pair, amountETH));

        // 调用pair合约的铸造方法，返回计算的流动性数值
        liquidity = IUniswapV2Pair(pair).mint(to);
        // refund dust eth, if any
        // 如果ETH输入的数额大于计算的最优解，则会将其中的差值退回到调用者账户
        if (msg.value > amountETH) TransferHelper.safeTransferETH(msg.sender, msg.value - amountETH);
    }

    // **** REMOVE LIQUIDITY ****
    // 移除流动性
    function removeLiquidity(
        address tokenA,          // tokenA地址
        address tokenB,          // tokenB地址
        uint liquidity,          // 流动性数值
        uint amountAMin,         // tokenA最小值
        uint amountBMin,         // tokenB最小值
        address to,              // 移除流动性给to地址
        uint deadline            // 最后期限
    ) public virtual override ensure(deadline) returns (uint amountA, uint amountB) {
        // 获取到pair合约地址
        address pair = UniswapV2Library.pairFor(factory, tokenA, tokenB);

        // 将流动性数值从用户发送到pair合约地址（需提前批准，在配对合约的销毁方法中可以使用到）
        IUniswapV2Pair(pair).transferFrom(msg.sender, pair, liquidity);                    // send liquidity to pair

        // 调用pair合约的burn方法，返回t0和t1在路由合约上的余额
        (uint amount0, uint amount1) = IUniswapV2Pair(pair).burn(to);

        // 将tokenA和tokenB进行排序，返回最小值token0
        (address token0,) = UniswapV2Library.sortTokens(tokenA, tokenB);
        // 进行三目运算：对amountA和amountB进行赋值
        (amountA, amountB) = tokenA == token0 ? (amount0, amount1) : (amount1, amount0);
        // 确保amountA大等于期望的最小数值
        require(amountA >= amountAMin, 'UniswapV2Router: INSUFFICIENT_A_AMOUNT');
        // 确保amountB大等于期望的最小数值
        require(amountB >= amountBMin, 'UniswapV2Router: INSUFFICIENT_B_AMOUNT');
    }

    // 移除ETH流动性
    function removeLiquidityETH(
        address token,           // tokenA地址
        uint liquidity,          // 流动性数值
        uint amountTokenMin,     // token最小数额
        uint amountETHMin,       // ETH最小数额
        address to,              // to 地址
        uint deadline            // 最后期限
    ) public virtual override ensure(deadline) returns (uint amountToken, uint amountETH) {
        // 调用公共的移除流动性方法，将ETH类比为一个token
        (amountToken, amountETH) = removeLiquidity(
            token,
            WETH,
            liquidity,
            amountTokenMin,
            amountETHMin,
            address(this),       // 当前合约地址
            deadline
        );

        // 将pair合约地址上的amountToken数额发送给to地址
        // 因为调用公共移除流动性方法时传入的to是当前合约地址，所以结束后应该把数额从当前地址发送给外部传入的to地址
        TransferHelper.safeTransfer(token, to, amountToken);
        // 将amountETH数额提出到以太坊的pair合约地址上
        IWETH(WETH).withdraw(amountETH);
        // 然后将pair合约的amountETH数额发送给to地址
        TransferHelper.safeTransferETH(to, amountETH);
    }

    //带签名移除流动性
    function removeLiquidityWithPermit(
        address tokenA,                 // tokenA地址
        address tokenB,                 // tokenB地址
        uint liquidity,                 // 流动性数额
        uint amountAMin,                // tokenA最小数额
        uint amountBMin,                // tokenB最小数额
        address to,                     // to地址
        uint deadline,                  // 最后期限
        bool approveMax,                // 是否全部批准
        uint8 v, bytes32 r, bytes32 s   // 签名数据
    ) external virtual override returns (uint amountA, uint amountB) {
        // 获取配对合约地址（create2方法部署的合约地址，可以通过tokenA和tokenB计算得来）
        address pair = UniswapV2Library.pairFor(factory, tokenA, tokenB);

        // 如果全部批准，value值 = uint256最大值，否则=流动性
        uint value = approveMax ? type(uint).max : liquidity;

        // permit方法来源与eip 712以太坊改进提案，将审批和发送操作放在一起，节省gas
        IUniswapV2Pair(pair).permit(msg.sender, address(this), value, deadline, v, r, s);

        // 调用公共的移除流动性方法
        (amountA, amountB) = removeLiquidity(tokenA, tokenB, liquidity, amountAMin, amountBMin, to, deadline);
    }

    // 带签名移除ETH流动性
    function removeLiquidityETHWithPermit(
        address token,
        uint liquidity,
        uint amountTokenMin,
        uint amountETHMin,
        address to,
        uint deadline,
        bool approveMax, uint8 v, bytes32 r, bytes32 s
    ) external virtual override returns (uint amountToken, uint amountETH) {
        //计算token、WETH 的create2地址，也就是配对合约地址
        address pair = UniswapV2Library.pairFor(factory, token, WETH);
        // 如果全部批准，value值 = uint256最大值，否则=流动性
        uint value = approveMax ? type(uint).max : liquidity;

        // permit方法来源与eip 712以太坊改进提案，将审批和发送操作放在一起，节省gas
        // 对批准操作进行签名，把v r s带入（将我的value数额批准给当前的路由合约）
        IUniswapV2Pair(pair).permit(msg.sender, address(this), value, deadline, v, r, s);

        // 调用更改的移除ETH流动性方法
        (amountToken, amountETH) = removeLiquidityETH(token, liquidity, amountTokenMin, amountETHMin, to, deadline);
    }

    // **** REMOVE LIQUIDITY (supporting fee-on-transfer tokens) ****
    // 移除ETH流动性（支持转移费用代币）
    // 就是上面几个移除流动性方法的整合版本
    function removeLiquidityETHSupportingFeeOnTransferTokens(
        address token,
        uint liquidity,
        uint amountTokenMin,
        uint amountETHMin,
        address to,
        uint deadline
    ) public virtual override ensure(deadline) returns (uint amountETH) {
        (, amountETH) = removeLiquidity(
            token,
            WETH,
            liquidity,
            amountTokenMin,
            amountETHMin,
            address(this),
            deadline
        );

        // 将token在ERC20上的余额发送给to地址
        TransferHelper.safeTransfer(token, to, IERC20(token).balanceOf(address(this)));
        IWETH(WETH).withdraw(amountETH);
        TransferHelper.safeTransferETH(to, amountETH);
    }

    // 带签名移除ETH流动性（支持费用转移）
    function removeLiquidityETHWithPermitSupportingFeeOnTransferTokens(
        address token,
        uint liquidity,
        uint amountTokenMin,
        uint amountETHMin,
        address to,
        uint deadline,
        bool approveMax, uint8 v, bytes32 r, bytes32 s
    ) external virtual override returns (uint amountETH) {
        address pair = UniswapV2Library.pairFor(factory, token, WETH);
        uint value = approveMax ? type(uint).max : liquidity;
        IUniswapV2Pair(pair).permit(msg.sender, address(this), value, deadline, v, r, s);
        amountETH = removeLiquidityETHSupportingFeeOnTransferTokens(
            token, liquidity, amountTokenMin, amountETHMin, to, deadline
        );
    }

    // **** SWAP ****
    // requires the initial amount to have already been sent to the first pair
    // 要求初始金额已经发送到第一对（私有公共交换方法）
    function _swap(
        uint[] memory amounts,            // 数额数组
        address[] memory path,            // 路径数组
        address _to                       // to地址

    ) internal virtual {
        // 遍历路径数组
        for (uint i; i < path.length - 1; i++) {
            // （输入地址，输出地址） = （当前地址，下一个地址）
            (address input, address output) = (path[i], path[i + 1]);
            // 进行地址大小排序
            (address token0,) = UniswapV2Library.sortTokens(input, output);
            // 输出数额 = 数组数额的下一个数值
            uint amountOut = amounts[i + 1];

            // 经过排序之后得到token0与input进行比较
            // 如果token0 = input ，则输出数额0就为0。否则amountOut0 = amountOut;
            // 解释：
            // 因为一个token对应着一个输入和一个输出，而交换方法就是使用一个token换取另一个token，那么对应着的
            // token 有输入input值，则输出out的值就为0；
            // 另一个token 则没有输入input值，就有输出out的值。
            (uint amount0Out, uint amount1Out) = input == token0 ? (uint(0), amountOut) : (amountOut, uint(0));

            // to地址 = 根据tokenA、tokenB计算出的create2的合约地址 || _to
            // 当路径数组的下标 i 遍历到倒数第二个时，所指向的就是最终需要交换出来的_to地址
            // 当 i 所指向的不是路径数组中的倒数第二个地址时，
            // 那么to地址就是当前输出地址output【path[i+1]】和下一个输出地址path[i+2]计算出来的create2合约地址
            address to = i < path.length - 2 ?
                UniswapV2Library.pairFor(factory, output, path[i + 2])
                : _to;

            // 调用配对合约的交换方法
            IUniswapV2Pair(UniswapV2Library.pairFor(factory, input, output)).swap(
                amount0Out, amount1Out, to,
                    new bytes(0)                  // 闪电贷，不执行的话传入0
            );
        }
    }

    // 外部交换方法（根据精确token交换尽量多的token）
    function swapExactTokensForTokens(
        uint amountIn,                    // 精确输入数额
        uint amountOutMin,                // 最小输出数额
        address[] calldata path,          // 路径数则
        address to,                       // to地址
        uint deadline                     // 最后期限
    ) external virtual override ensure(deadline) returns (uint[] memory amounts) {

        // 数额数额 = 计算每个合约对交换扣税之后的输出数额
        // 遍历路径数组((输入数额 * 997 * 储备量Out) / (储备量In * 1000 + 输入数额 * 997))
        amounts = UniswapV2Library.getAmountsOut(factory, amountIn, path);

        // 确保数额数组的最后一个元素值大等于最小输入数额
        require(amounts[amounts.length - 1] >= amountOutMin, 'UniswapV2Router: INSUFFICIENT_OUTPUT_AMOUNT');

        // 将path[0]token价值amounts[0]的数额从调用者账户发送到path[0]和path[1]的配对合约上
        TransferHelper.safeTransferFrom(
            path[0], msg.sender, UniswapV2Library.pairFor(factory, path[0], path[1]), amounts[0]
        );
        // 调用私有的交换方法
        _swap(amounts, path, to);
    }

    // 使用尽量少的token交换到精确的token
    function swapTokensForExactTokens(
        uint amountOut,             // 输出精确token
        uint amountInMax,           // 输入的最大token
        address[] calldata path,    //路径数组
        address to,                 // to地址
        uint deadline               // 最后期限
    ) external virtual override ensure(deadline) returns (uint[] memory amounts) {

        // 获取扣税之后的数额数组
        // 遍历路径数组((储备量In * 储备量Out * 1000) / (储备量Out - 输出数额 * 997) + 1)
        amounts = UniswapV2Library.getAmountsIn(factory, amountOut, path);

        // 确保第一个输入输入小等于最大的输入数额
        require(amounts[0] <= amountInMax, 'UniswapV2Router: EXCESSIVE_INPUT_AMOUNT');

        // 将path[0]token价值amounts[0]的数额从调用者账户发送到path[0]和path[1]的配对合约上
        TransferHelper.safeTransferFrom(
            path[0], msg.sender, UniswapV2Library.pairFor(factory, path[0], path[1]), amounts[0]
        );
        // 调用私有的交换方法
        _swap(amounts, path, to);
    }

    // 根据精确的ETH交换尽量多的token
    function swapExactETHForTokens(
        uint amountOutMin,             // 最小输出数额
        address[] calldata path,       // 路径地址
        address to,                    // to地址
        uint deadline                  //  最后期限
    ) external
        virtual
        override
        payable
        ensure(deadline)
    returns (uint[] memory amounts)
    {
        // 确保路径中的第一个地址为WETH
        require(path[0] == WETH, 'UniswapV2Router: INVALID_PATH');
        // 获得数额数组(msg.vlaue 作为输入数额)
        amounts = UniswapV2Library.getAmountsOut(factory, msg.value, path);

        // 确保数额数组的最后一个金额大等于最小输出金额
        require(amounts[amounts.length - 1] >= amountOutMin, 'UniswapV2Router: INSUFFICIENT_OUTPUT_AMOUNT');

        // 将数额数组的第一个数值（ETH的msg.value）存入WETH合约中
        IWETH(WETH).deposit{value: amounts[0]}();
        assert(
            // 将数额数组[0]的数额的WETH发送到路径(0,1)的pair合约地址
            IWETH(WETH).transfer(UniswapV2Library.pairFor(factory, path[0], path[1]), amounts[0])
        );

        //调用私有交换方法
        _swap(amounts, path, to);
    }

    // 使用尽量少的token换取精确的ETH
    function swapTokensForExactETH(
        uint amountOut,                // 精确的输出数额（ETH）
        uint amountInMax,              // 最大输入数额
        address[] calldata path,       // 路径数组
        address to,                    // to地址
        uint deadline                  // 最后期限
    ) external
        virtual
        override
        ensure(deadline)
    returns (uint[] memory amounts)
    {
        // 确保最后一个地址为WETH
        require(path[path.length - 1] == WETH, 'UniswapV2Router: INVALID_PATH');
        // 根据最后输出数额，倒叙计算出数额数组
        amounts = UniswapV2Library.getAmountsIn(factory, amountOut, path);

        // 确保第一个输入数额小等于最大输入数额
        require(amounts[0] <= amountInMax, 'UniswapV2Router: EXCESSIVE_INPUT_AMOUNT');

        // 将path[0]地址的amonts[0]数额从调用者发送到path[0]和path[1]的配对合约地址中
        TransferHelper.safeTransferFrom(
            path[0], msg.sender, UniswapV2Library.pairFor(factory, path[0], path[1]), amounts[0]
        );
        // 调用私有交换方法
        // to 地址暂时为当前合约地址
        _swap(amounts, path, address(this));

        // 从WETH合约中提款，数量为数额数组的最后一个元素的数值
        IWETH(WETH).withdraw(amounts[amounts.length - 1]);
        // 从WETH合约地址中将数额数组的最后一个数值发送到to地址
        TransferHelper.safeTransferETH(to, amounts[amounts.length - 1]);
    }

    // 使用精确Token交换尽量多的ETH
    function swapExactTokensForETH(
        uint amountIn,                  // 输入token数额
        uint amountOutMin,              // 最小输出数额
        address[] calldata path,        // 路径地址
        address to,                     // to 地址
        uint deadline                   // 最后期限
    ) external
        virtual
        override
        ensure(deadline)
    returns (uint[] memory amounts)
    {
        // 确保最后一个地址为WETH
        require(path[path.length - 1] == WETH, 'UniswapV2Router: INVALID_PATH');

        // 根据输入token数额，计算得到输出数额数组
        amounts = UniswapV2Library.getAmountsOut(factory, amountIn, path);

        // 确保输出数额数组的最后一个值大等于最小输出数额
        require(amounts[amounts.length - 1] >= amountOutMin, 'UniswapV2Router: INSUFFICIENT_OUTPUT_AMOUNT');

        // 将path[0]地址的amounts[0]数额从调用者发送到path[0]和path[1]的配对合约地址中
        TransferHelper.safeTransferFrom(
            path[0], msg.sender, UniswapV2Library.pairFor(factory, path[0], path[1]), amounts[0]
        );
        // 私有交换方法，to地址暂时为合约地址
        _swap(amounts, path, address(this));

        // 提款操作。 从合约地址上提取amounts数额数组的最后一个数值
        IWETH(WETH).withdraw(amounts[amounts.length - 1]);

        // 将ETH在合约地址提出的数额发送到to地址
        TransferHelper.safeTransferETH(to, amounts[amounts.length - 1]);
    }

    // 使用尽量少的ETH交换到精确的Token
    function swapETHForExactTokens(
        uint amountOut,                 // 精确的输出数额（token）
        address[] calldata path,        // 路径地址
        address to,                     // to地址
        uint deadline                   // 最后期限
    ) external
        virtual
        override
        payable
        ensure(deadline)
    returns (uint[] memory amounts)
    {
        // 确保路径数组中的第一个地址为WETH
        require(path[0] == WETH, 'UniswapV2Router: INVALID_PATH');

        // 根据精确的输出数额，倒叙计算出输入数额数组
        amounts = UniswapV2Library.getAmountsIn(factory, amountOut, path);

        // 确保输入数组的第一个数额小等于最大输入数额
        require(amounts[0] <= msg.value, 'UniswapV2Router: EXCESSIVE_INPUT_AMOUNT');

        // 存款操作。将ETH的输入数额存入WETH合约中。
        IWETH(WETH).deposit{value: amounts[0]}();
        assert(
            // 将amount[0]数额的ETH从WETH地址发送到path[0]和path[1]的配对合约地址中
            IWETH(WETH).transfer(UniswapV2Library.pairFor(factory, path[0], path[1]), amounts[0])
        );
        // 调用私有交换方法
        _swap(amounts, path, to);
        // refund dust eth, if any
        // 如果收到的主币(ETH msg.value) 数量大于计算出来的amounts[0]数额
        // 将多余的主币返回到调用者账户
        if (msg.value > amounts[0]) TransferHelper.safeTransferETH(msg.sender, msg.value - amounts[0]);
    }


    // **** SWAP (supporting fee-on-transfer tokens) ****
    // requires the initial amount to have already been sent to the first pair
    // 支持收税的私有交换方法
    function _swapSupportingFeeOnTransferTokens(address[] memory path, address _to) internal virtual {
        for (uint i; i < path.length - 1; i++) {
            (address input, address output) = (path[i], path[i + 1]);
            (address token0,) = UniswapV2Library.sortTokens(input, output);
            IUniswapV2Pair pair = IUniswapV2Pair(UniswapV2Library.pairFor(factory, input, output));
            uint amountInput;
            uint amountOutput;
            { // scope to avoid stack too deep errors
                (uint reserve0, uint reserve1,) = pair.getReserves();
                (uint reserveInput, uint reserveOutput) = input == token0 ? (reserve0, reserve1) : (reserve1, reserve0);


                amountInput = IERC20(input).balanceOf(address(pair)).sub(reserveInput);
                amountOutput = UniswapV2Library.getAmountOut(amountInput, reserveInput, reserveOutput);
            }
            (uint amount0Out, uint amount1Out) = input == token0 ? (uint(0), amountOutput) : (amountOutput, uint(0));
            address to = i < path.length - 2 ? UniswapV2Library.pairFor(factory, output, path[i + 2]) : _to;
            pair.swap(amount0Out, amount1Out, to, new bytes(0));
        }
    }


    function swapExactTokensForTokensSupportingFeeOnTransferTokens(
        uint amountIn,
        uint amountOutMin,
        address[] calldata path,
        address to,
        uint deadline
    ) external virtual override ensure(deadline) {
        TransferHelper.safeTransferFrom(
            path[0], msg.sender, UniswapV2Library.pairFor(factory, path[0], path[1]), amountIn
        );
        uint balanceBefore = IERC20(path[path.length - 1]).balanceOf(to);
        _swapSupportingFeeOnTransferTokens(path, to);
        require(
            IERC20(path[path.length - 1]).balanceOf(to).sub(balanceBefore) >= amountOutMin,
            'UniswapV2Router: INSUFFICIENT_OUTPUT_AMOUNT'
        );
    }


    function swapExactETHForTokensSupportingFeeOnTransferTokens(
        uint amountOutMin,
        address[] calldata path,
        address to,
        uint deadline
    )
        external
        virtual
        override
        payable
        ensure(deadline)
    {
        require(path[0] == WETH, 'UniswapV2Router: INVALID_PATH');
        uint amountIn = msg.value;
        IWETH(WETH).deposit{value: amountIn}();
        assert(IWETH(WETH).transfer(UniswapV2Library.pairFor(factory, path[0], path[1]), amountIn));
        uint balanceBefore = IERC20(path[path.length - 1]).balanceOf(to);
        _swapSupportingFeeOnTransferTokens(path, to);
        require(
            IERC20(path[path.length - 1]).balanceOf(to).sub(balanceBefore) >= amountOutMin,
            'UniswapV2Router: INSUFFICIENT_OUTPUT_AMOUNT'
        );
    }


    function swapExactTokensForETHSupportingFeeOnTransferTokens(
        uint amountIn,
        uint amountOutMin,
        address[] calldata path,
        address to,
        uint deadline
    )
        external
        virtual
        override
        ensure(deadline)
    {
        require(path[path.length - 1] == WETH, 'UniswapV2Router: INVALID_PATH');
            TransferHelper.safeTransferFrom(
            path[0], msg.sender, UniswapV2Library.pairFor(factory, path[0], path[1]), amountIn
        );
        _swapSupportingFeeOnTransferTokens(path, address(this));
        uint amountOut = IERC20(WETH).balanceOf(address(this));
        require(amountOut >= amountOutMin, 'UniswapV2Router: INSUFFICIENT_OUTPUT_AMOUNT');
        IWETH(WETH).withdraw(amountOut);
        TransferHelper.safeTransferETH(to, amountOut);
    }


    // **** LIBRARY FUNCTIONS ****
    function quote(uint amountA, uint reserveA, uint reserveB) public pure virtual override returns (uint amountB) {
        return UniswapV2Library.quote(amountA, reserveA, reserveB);
    }

    function getAmountOut(uint amountIn, uint reserveIn, uint reserveOut)
        public
        pure
        virtual
        override
    returns (uint amountOut)
    {
        return UniswapV2Library.getAmountOut(amountIn, reserveIn, reserveOut);
    }

    function getAmountIn(uint amountOut, uint reserveIn, uint reserveOut)
        public
        pure
        virtual
        override
    returns (uint amountIn)
    {
        return UniswapV2Library.getAmountIn(amountOut, reserveIn, reserveOut);
    }

    function getAmountsOut(uint amountIn, address[] memory path)
        public
        view
        virtual
        override
    returns (uint[] memory amounts)
    {
        return UniswapV2Library.getAmountsOut(factory, amountIn, path);
    }

    function getAmountsIn(uint amountOut, address[] memory path)
        public
        view
        virtual
        override
    returns (uint[] memory amounts)
    {
        return UniswapV2Library.getAmountsIn(factory, amountOut, path);
    }
}

// a library for performing overflow-safe math, courtesy of DappHub (https://github.com/dapphub/ds-math)

library SafeMath {
    function add(uint x, uint y) internal pure returns (uint z) {
        require((z = x + y) >= x, 'ds-math-add-overflow');
    }

    function sub(uint x, uint y) internal pure returns (uint z) {
        require((z = x - y) <= x, 'ds-math-sub-underflow');
    }

    function mul(uint x, uint y) internal pure returns (uint z) {
        require(y == 0 || (z = x * y) / y == x, 'ds-math-mul-overflow');
    }
}


library UniswapV2Library {
    using SafeMath for uint;

    // returns sorted token addresses, used to handle return values from pairs sorted in this order
    // 返回排序的令牌地址，用于处理按此顺序排序的对中的返回值
    function sortTokens(address tokenA, address tokenB) internal pure returns (address token0, address token1) {
        require(tokenA != tokenB, 'UniswapV2Library: IDENTICAL_ADDRESSES');
        (token0, token1) = tokenA < tokenB ? (tokenA, tokenB) : (tokenB, tokenA);
        require(token0 != address(0), 'UniswapV2Library: ZERO_ADDRESS');
    }

    // calculates the CREATE2 address for a pair without making any external calls
    // 在不进行任何外部调用的情况下计算一对的CREATE2地址
    // 任何通过create2部署的合约地址都可以通过以下计算方式得出
    function pairFor(address factory, address tokenA, address tokenB) internal pure returns (address pair) {
        (address token0, address token1) = sortTokens(tokenA, tokenB);
        pair = address(uint160(uint(keccak256(abi.encodePacked(
            hex'ff',
            factory,
            keccak256(abi.encodePacked(token0, token1)),                          // salt
            // pair合约bytecode的keccak256 (直接硬编码放在此处)
            hex'96e8ac4277198ff8b6f785478aa9a39f403cb768dd02cbee326c3e7da348845f' // init code hash
        )))));
    }

    // fetches and sorts the reserves for a pair
    // 获取并排序一对的储备金
    function getReserves(address factory, address tokenA, address tokenB) internal view returns (uint reserveA, uint reserveB) {
        // 对tokenA和tokenB进行排序，并返回token0（最小的地址）
        (address token0,) = sortTokens(tokenA, tokenB);

        // pairFor(factory, tokenA, tokenB) ==》 获取pair的合约地址
        // reserve {0,1}  =  IUniswapV2Pair(pair合约地址).getReserves()
        (uint reserve0, uint reserve1,) = IUniswapV2Pair(pairFor(factory, tokenA, tokenB)).getReserves();
        // 返回reserve{A,B}
        (reserveA, reserveB) = tokenA == token0 ? (reserve0, reserve1) : (reserve1, reserve0);
    }

    // given some amount of an asset and pair reserves, returns an equivalent amount of the other asset
    // 给定一定数量的资产和货币对准备金，则返回等值的其他资产 (对价计算)
    function quote(uint amountA, uint reserveA, uint reserveB) internal pure returns (uint amountB) {
        // 校验数值A大于0
        require(amountA > 0, 'UniswapV2Library: INSUFFICIENT_AMOUNT');
        // 校验储备A和储备B都大于0
        require(reserveA > 0 && reserveB > 0, 'UniswapV2Library: INSUFFICIENT_LIQUIDITY');
        // 数值B = 数值A / 储备A * 储备B
        amountB = amountA.mul(reserveB) / reserveA;
    }

    // given an input amount of an asset and pair reserves, returns the maximum output amount of the other asset
    // 给定一项资产和对储备的输入量，则返回另一项资产的最大产出量
    // 获取单个输出数额
    function getAmountOut(
        uint amountIn,           // 输入数额
        uint reserveIn,          // 输入储备量
        uint reserveOut          // 输出储备量
    ) internal pure returns (uint amountOut) {
        // 确保输入数额大于0
        require(amountIn > 0, 'UniswapV2Library: INSUFFICIENT_INPUT_AMOUNT');
        // 确保储备量大于0
        require(reserveIn > 0 && reserveOut > 0, 'UniswapV2Library: INSUFFICIENT_LIQUIDITY');

        // 税后输入数额 = 输入数额 * 997
        uint amountInWithFee = amountIn.mul(997);

        // 分子 = 税后输入数额 * 输出储备量
        uint numerator = amountInWithFee.mul(reserveOut);
        // 分母 = 输入储备量 * 1000 + 税后输入数额                    TODO 还未明白为什么分母要加上amountInWithFee
        uint denominator = reserveIn.mul(1000).add(amountInWithFee);
        // 输出数额 = 分子 / 分母
        amountOut = numerator / denominator;
    }

    // given an output amount of an asset and pair reserves, returns a required input amount of the other asset
    // 给定一项资产和对储备的输出量，则返回其他资产的所需输入量
    function getAmountIn(
        uint amountOut,          // 输出数额
        uint reserveIn,          // 输入储备量
        uint reserveOut          // 输出储备量
    ) internal pure returns (uint amountIn) {
        // 确保输出数额大于0
        require(amountOut > 0, 'UniswapV2Library: INSUFFICIENT_OUTPUT_AMOUNT');
        // 确保输入储备量和输出储备量大于0
        require(reserveIn > 0 && reserveOut > 0, 'UniswapV2Library: INSUFFICIENT_LIQUIDITY');

        // 分子 = 输入储备量 * 输出数额 * 1000
        uint numerator = reserveIn.mul(amountOut).mul(1000);
        // 分母 = (输出储备量 - 输出数额) * 997
        uint denominator = reserveOut.sub(amountOut).mul(997);
        // 输入数额 = 分子 / 分母 + 1
        amountIn = (numerator / denominator).add(1);
    }

    // performs chained getAmountOut calculations on any number of pairs
    // 在任意数量的对上执行链接的getAmountOut计算
    // 获取输出数额数组
    function getAmountsOut(address factory, uint amountIn, address[] memory path) internal view returns (uint[] memory amounts) {
        // 确保路径数组数量大等于2
        require(path.length >= 2, 'UniswapV2Library: INVALID_PATH');
        // 定义一个定长的uint数组，保存输出数额
        amounts = new uint[](path.length);
        // 数组[0] = 输入数额
        amounts[0] = amountIn;
        // 遍历路径数组，将计算税后的输出数额赋值给输出数额数组中
        for (uint i; i < path.length - 1; i++) {
            // 获取tokenA和tokenB的配对合约上的储备量{A,B}
            (uint reserveIn, uint reserveOut) = getReserves(factory, path[i], path[i + 1]);

            // 调用getAmountOut方法，计算得到下一个数额
            amounts[i + 1] = getAmountOut(amounts[i], reserveIn, reserveOut);
        }
    }

    // performs chained getAmountIn calculations on any number of pairs
    // 在任意数量的对上执行链接的getAmountIn计算
    function getAmountsIn(address factory, uint amountOut, address[] memory path) internal view returns (uint[] memory amounts) {
        //确认路径数组长度大于2
        require(path.length >= 2, "UniswapV2Library: INVALID_PATH");
        //初始化数额数组
        amounts = new uint256[](path.length);
        //数额数组最后一个元素 = 输出数额
        amounts[amounts.length - 1] = amountOut;
        //从倒数第二个元素倒叙遍历路径数组
        for (uint i = path.length - 1; i > 0; i--) {
            // 获取储备量
            (uint reserveIn, uint reserveOut) = getReserves(factory, path[i - 1], path[i]);
            // 获取上一个数额
            amounts[i - 1] = getAmountIn(amounts[i], reserveIn, reserveOut);
        }
    }
}


// helper methods for interacting with ERC20 tokens and sending ETH that do not consistently return true/false
library TransferHelper {
    function safeApprove(address token, address to, uint value) internal {
        // bytes4(keccak256(bytes('approve(address,uint256)')));
        (bool success, bytes memory data) = token.call(abi.encodeWithSelector(0x095ea7b3, to, value));
        require(success && (data.length == 0 || abi.decode(data, (bool))), 'TransferHelper: APPROVE_FAILED');
    }

    function safeTransfer(address token, address to, uint value) internal {
        // bytes4(keccak256(bytes('transfer(address,uint256)')));
        (bool success, bytes memory data) = token.call(abi.encodeWithSelector(0xa9059cbb, to, value));
        require(success && (data.length == 0 || abi.decode(data, (bool))), 'TransferHelper: TRANSFER_FAILED');
    }

    function safeTransferFrom(address token, address from, address to, uint value) internal {
        // bytes4(keccak256(bytes('transferFrom(address,address,uint256)')));
        (bool success, bytes memory data) = token.call(abi.encodeWithSelector(0x23b872dd, from, to, value));
        require(success && (data.length == 0 || abi.decode(data, (bool))), 'TransferHelper: TRANSFER_FROM_FAILED');
    }

    function safeTransferETH(address to, uint value) internal {
        (bool success,) = to.call{value:value}(new bytes(0));
        require(success, 'TransferHelper: ETH_TRANSFER_FAILED');
    }
}