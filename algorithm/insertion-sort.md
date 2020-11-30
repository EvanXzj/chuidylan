# 插入排序

**插入排序**类似整理扑克牌，将每一张牌插到其他已经有序的牌中适当的位置。它也是重要的基本算法之一，也是面试者需要掌握的算法之一。

## 算法步骤

    1. 将第一待排序序列第一个元素看做一个有序序列，把第二个元素到最后一个元素当成是未排序序列；

    2. 将该元素抽取出来，然后按照从右往左的顺序分别与其左边的元素比较，遇到比其大的元素便将元素右移，
       直到找到比该元素小的元素或者找到最左面发现其左侧的元素都比它大，停止；

    3. 此时会出现一个空位，将该元素放入到空位中；

    4. 重复上述过程。每操作一轮，左侧有序元素都增加一个，右侧无序元素都减少一个。

## 动态演示

![insert sort](https://github.com/EvanXzj/JS-Sorting-Algorithm/raw/master/res/insertionSort.gif)

> 图片源自GitHub

## 算法复杂度

1. 时间复杂度是O(n^2)

2. 空间复杂度是O(1)

## Javascript 代码实现

```js
function insertionSort(arr) {
    const len = arr.length
    let [preIndex, current] = []

    for(let i = 1; i < len; ++i) {
        preIndex = i - 1
        current = arr[i]

        while(preIndex >= 0 && arr[preIndex] > current) {
            arr[preIndex + 1] = arr[preIndex]
            --preIndex
        }

        arr[preIndex + 1] = current     // 在空位插入当前元素
    }

    return arr
}
```

## Go代码实现

```go
func insertionSort(arr []int) []int {
    for i := range arr {
        preIndex := i - 1
        current := arr[i]

        for preIndex >=0 && arr[preIndex] > current {
            arr[preIndex + 1] = arr[preIndex]
            preIndex -= 1
        }

        arr[preIndex + 1] = current       // 在空位插入当前元素
    }

    return arr
}
```
