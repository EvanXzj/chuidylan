# Javascript Symbol 实用指南

JavaScript在ES6中引入了符号来防止属性名称冲突。此外，在2015-2019年的JavaScript中，符号还提供了一种模拟私有属性的方法。

> 原文链接：[A Practical Guide to Symbols in JavaScript](http://thecodebarbarian.com/a-practical-guide-to-symbols-in-javascript.html)


## 介绍

在JavaScript中创建symbol的最简单方法是调用`Symbol()`函数。使symbol如此特殊的两个关键属性是:

- 符号可以用作对象键。只有字符串和symbol可以用作对象键。
- 没有两个symbol是相等的。

```javascript
const s1 = Symbol()
const s2 = Symblo()

s1 === s2 // false

const obj = {}

obj[s1] = 'hello'
obj[s2] = 'world'

obj[s1] // 'hello'
obj[s2] // 'world'
```

尽管Symbol()调用使它看起来像是对象，但在JavaScript中，symblo实际上是[Javascript基本类型](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Data_structures)。使用new 关键字调用Symbol会报错。

```js
const s1 = Symbol()

typeof s1 // 'symbol'
s1 instanceof Object // false

// Throws "TypeError: Symbol is not a constructor"
new Symbol()
```

## 描述

Symbol()函数只接受一个参数，即字符串描述`description`。symbol的描述仅用于调试目的——`description`显示在符号的toString()的输出中。然而，具有相同描述的两个symbol是不相等的。

```js
const s1 = Symbol('my symbol')
const s2 = Symbol('my symbol')

s1 === s2; // false
console.log(s1); // 'Symbol(my symbol)'
```

还有一个全局symbol注册表。通过Symbol.for()创建symbol会将其添加到全局注册表中，由symbol的描述作为键值。换句话说，如果您使用Symbol.for()创建两个具有相同描述的symbol，那么这两个symbol是相等的。

```javascript
const s1 = Symbol.for('test');
const s1 = Symbol.for('test');

s1 === s2; // true
console.log(s1); // 'Symbol(test)'
```

一般来说，除非有很好的理由，否则不应该使用全局symbol注册表，因为可能会遇到命名冲突。


## 命名冲突

JavaScript ES6 中的第一个内置symbol 是[`Symbol.iterator`symbol](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/Symbol/iterator)。具有`Symbol.iterator`方法的对象被认为是[*可迭代的*](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Iteration_protocols#The_iterable_protocol)。这意味着您可以通过[`for/of`循环](http://thecodebarbarian.com/for-vs-for-each-vs-for-in-vs-for-of-in-javascript)来遍历对象。

```js
const fibonacci = {
  [Symbol.iterator]: function*() {
    let a = 1;
    let b = 1;
    let temp;

    yield b;

    while (true) {
      temp = a;
      a = a + b;
      b = temp;
      yield b;
    }
  }
};

// Prints every Fibonacci number less than 100
for (const x of fibonacci) {
  if (x >= 100) {
    break;
  }
  console.log(x);
}
```

为什么`Symbol.iterator`用symbol而不是字符串？假设不是使用`Symbol.iterator`，可迭代规范检查了字符串属性的存在`'iterator'`。此外，假设您具有下面的类，该类是可迭代的。

```javascript
class MyClass {
  constructor(obj) {
    Object.assign(this, obj);
  }

  iterator() {
    const keys = Object.keys(this);
    let i = 0;
    return (function*() {
      if (i >= keys.length) {
        return;
      }
      yield keys[i++];
    })();
  }
}
```

`MyClass`的实例将是可迭代的，可让您迭代对象的键。但是以上类别也有潜在的缺陷。假设恶意用户要将具有`iterator`属性的对象传递给`MyClass`。

```javascript
const obj = new MyClass({ iterator: 'not a function' });
```

如果要使用`for/of`遍历 `obj`，JavaScript会抛出异常`TypeError: obj is not iterable`。这是因为用户指定的`iterator`函数将覆盖类的迭代器属性。这是与[原型污染](http://thecodebarbarian.com/mongoose-prototype-pollution-vulnerability-disclosure)类似的安全问题，在这种情况下，天真地复制用户数据可能会导致具有诸如[`__proto__`](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/Object/proto)和的特殊属性的问题[`constructor`](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/Object/constructor)。

## 私有属性

由于没有两个symbol相等，因此symbolk是在JavaScript中模拟私有属性的便捷方法。symbol不会出现在中`Object.keys()`，因此，除非您显式地`export`倒出，否则除非您显式地通过[`Object.getOwnPropertySymbols()`方法获取](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/Object/getOwnPropertySymbols)，否则其他代码都不能访问该属性。

```javascript
function getObj() {
  const symbol = Symbol('test');
  const obj = {};
  obj[symbol] = 'test';
  return obj;
}

const obj = getObj();

Object.keys(obj); // []

// Unless you explicitly have a reference to the symbol, you can't access the
// symbol property.
obj[Symbol('test')]; // undefined

// You can still get a reference to the symbol using `getOwnPropertySymbols()`
const [symbol] = Object.getOwnPropertySymbols(obj);
obj[symbol]; // 'test'
```

symbol对于私有属性很方便，也因为它们不会显示在[`JSON.stringify()`输出中](http://thecodebarbarian.com/the-80-20-guide-to-json-stringify-in-javascript.html)。具体来说，[`JSON.stringify()`默认忽略symbol键和值](https://masteringjs.io/tutorials/fundamentals/stringify#converting-values-to-json)。

```javascript
const symbol = Symbol('test');
const obj = { [symbol]: 'test', test: symbol };

JSON.stringify(obj); // "{}"
```