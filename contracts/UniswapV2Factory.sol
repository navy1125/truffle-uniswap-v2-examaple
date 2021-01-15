pragma solidity >=0.8.0;

// SPDX-License-Identifier: GPL-3.0
import './interfaces/IUniswapV2Factory.sol';
import './UniswapV2Pair.sol';

// Uniswap工厂合约
contract UniswapV2Factory is IUniswapV2Factory {
    address public override feeTo;              // 收税地址（0.005%的协议费用，到目前为止uniswap也没有设置）
    address public override feeToSetter;        // 收税权限地址

    // 配对合约映射
    mapping(address => mapping(address => address)) public override getPair;
    address[] public override allPairs;         // 存放所有配对合约的数组

    // 创建配对合约事件
    //event PairCreated(address indexed token0, address indexed token1, address pair, uint);

    // 构造方法，初始化收税地址（可以给自己，也可以给其它地址）
    constructor(address _feeToSetter) {
        feeToSetter = _feeToSetter;
    }

    // 获取所有的配对合约数量
    function allPairsLength() external override view returns (uint) {
        return allPairs.length;
    }

    // @dev 创建配对合约
    function createPair(address tokenA, address tokenB) external override returns (address pair) {
        require(tokenA != tokenB, 'UniswapV2: IDENTICAL_ADDRESSES');

        // tA 和 tB 进行排序，确保tA小于tB。返回对应的t0和t1
        (address token0, address token1) = tokenA < tokenB ? (tokenA, tokenB) : (tokenB, tokenA);
        // 判断tA 地址不为0，继而判断出tB 地址也不为0
        require(token0 != address(0), 'UniswapV2: ZERO_ADDRESS');

        // 校验tA 和 tB 的地址不存在配对过
        // mapping(address => mapping(address => address)) public getPair;
        require(getPair[token0][token1] == address(0), 'UniswapV2: PAIR_EXISTS'); // single check is sufficient

        // 通过引入UniswapV2Pair合约，不使用继承的方式。
        // 使用type(合约名称).creationCode 方法获得该合约编译之后的字节码
        bytes memory bytecode = type(UniswapV2Pair).creationCode;

        // abi.encodePacked()     编码打包
        // keccak256              Solidity 内置加密Hash方法
        // keccak256(abi.encodePacked(a, b))是计算keccak256(a, b)更明确的方式
        bytes32 salt = keccak256(abi.encodePacked(token0, token1));

        // 内联汇编
        // mload(bytecode)          返回长度
        // create2                  新的操作码 （opcode 操作码是程序的低级可读指令, 所有操作码都具有对应的十六进制值）
        assembly {                  // 使用汇编Opcode来操作EVM字节码，可以节省gas和做一些无法通过Solidity完成的事情
        //通过create2方法布署合约,并且加盐,返回地址到pair变量
            pair := create2(0, add(bytecode, 32), mload(bytecode), salt)
        }

        // 调用pair合约的初始化方法，传入参数tA tB
        IUniswapV2Pair(pair).initialize(token0, token1);

        // mapping(address => mapping(address => address)) public getPair;
        getPair[token0][token1] = pair;
        getPair[token1][token0] = pair; // 反向填充映射

        // 将该合约push到合约数组中保存
        allPairs.push(pair);
        // 触发合约配对成功事件
        emit PairCreated(token0, token1, pair, allPairs.length);
    }

    // 设置收税地址
    function setFeeTo(address _feeTo) external override {
        require(msg.sender == feeToSetter, 'UniswapV2: FORBIDDEN');
        feeTo = _feeTo;
    }

    // 设置收税权限
    function setFeeToSetter(address _feeToSetter) external override {
        require(msg.sender == feeToSetter, 'UniswapV2: FORBIDDEN');
        feeToSetter = _feeToSetter;
    }
}
