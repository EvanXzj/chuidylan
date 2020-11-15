# Bitcoin core 搭建 regtest测试链

## 1. 安装bitcoin core

```bash
# TODO
http://ju.outofmemory.cn/entry/356416

```

## 2. 配置文件

```conf
# btc_private_chain/data/bitcoin.conf
server=1
rpcuser=123456
rpcpassword=abcdef
rpcallowip=127.0.0.1
[regtest]
    rpcport=8332
```

## 3. 启动regtest节点

```sh
# 目录btc_private_chain
bitcoind -datadir=data -regtest -printtoconsole
```

## 4. 新增地址

```
bitcoin-cli -datadir=data getnewaddress 'xyz'
# print address
```

## 5. 挖矿

```
bitcoin-cli -datadir=data generatetoaddress 101 "address"
```

## 6. sendtoaddress 简单消费(转账)

```
bitcoin-cli -datadir=data sendtoaddress "address" 10
```

## 7. 确认

```
bitcoin-cli -datadir=data generatetoaddress 1 "address"
```

## 8. 查看余额

```
bitcoin-cli -datadir=data listaddressgroupings
```

## 9. 查看区块高度

```
bitcoin-cli -datadir=data getblockcount
```

## 10. 查看区块信息

```
bitcoin-cli -datadir=data getblockhash 102
# output: hash
bitcoin-cli -datadir=data getblock "hash"
```

## 11. 查看交易信息

```
bitcoin-cli -datadir=data gettransaction "txid"
```

## 12. 创建简单的原生交易

TODO

## 13. 创建复杂的原生交易

TODO

## 其他链接

0. https://bitcoin.org/en/developer-examples#transactions
1. https://bitcoin.org/en/developer-reference#sendtoaddress
2. https://www.jianshu.com/p/09c5207b4e5d
3. https://stackoverflow.com/questions/38152663/bitcoin-how-to-build-raw-transaction
4. https://blog.csdn.net/a013152/article/details/81668629