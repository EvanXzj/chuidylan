# Geth搭建以太坊私链

## 1. 下载安装Geth

```sh
brew tap ethereum/ethereum
brew install ethereum
```

## 2. 准备创世区块配置文件genesis.json

```json
{
  "config": {
        "chainId": 10,
        "homesteadBlock": 0,
        "eip155Block": 0,
        "eip158Block": 0
    },
  "coinbase"   : "0x0000000000000000000000000000000000000000",
  "difficulty" : "0x20000",
  "extraData"  : "",
  "gasLimit"   : "0xffffffff",
  "nonce"      : "0x0000000000000042",
  "mixhash"    : "0x0000000000000000000000000000000000000000000000000000000000000000",
  "parentHash" : "0x0000000000000000000000000000000000000000000000000000000000000000",
  "timestamp"  : "0x00",
  "alloc"      : {}
}
```

## 3. 写入创世区块

```sh
geth --datadir data init genesis.json
```

## 4. 启动私有节点

```sh
geth --datadir data --networkid 1001 console
```

## 5. 创建账户

```sh
personal.newAccount('123456') # 123456是密码
personal.newAccount('123456')

# 默认eth.accounts[0]为矿工账户
```

## 6. 挖矿

```sh
miner.start();admin.sleepBlocks(1);miner.stop()
```

## 7. 发送交易

```sh
amount = web3.toWei(5, 'ether')

eth.sendTransaction({from: eth.accounts[0], to: eth.accounts[1], value: amount}) # 输出txHash
```

## 8. 查看交易池状态

```sh
txpool.status
```

## 9. 挖矿打包交易

```sh
miner.start(1); admin.sleepBlocks(1); miner.stop() # 启动挖矿，然后等待挖到一个区块之后就停止挖矿
```

## 10. 查看余额

```sh
txpool.status

web3.fromWei(eth.getBalance(eth.accounts[1]), 'ether') # 输出为5
```

## 11. 其他

```sh
# 查看区块高度
eth.blockNumber

# 查看区块信息
eth.getBlock(10)

# 查看交易信息
eth.getTransaction(txHash)

# 查看节点信息
admin.nodeInfo
```

## 参考链接

1. https://www.cnblogs.com/WPF0414/p/10046481.html
2. https://blog.csdn.net/dieju8330/article/details/81542916