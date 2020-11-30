# 选择排序


**选择排序(Selection Sort)** 是一种简单直观的排序算法。它也是重要的基本算法之一，也是面试者需要掌握的算法之一。

## 算法步骤

    1. 在初始未排序序列中找到最小（大）元素，放到序列的起始位置作为 已排序序列。

    2. 然后再从剩余未排序的序列中找到最小（大）元素，放到已排序序列的末尾。

    3. 重复第二步，直到所有元素已排序为止。

## 动图演示

![选择排序](https://github.com/EvanXzj/JS-Sorting-Algorithm/blob/master/res/selectionSort.gif?raw=true)

> 图片源自GitHub

## 算法复杂度

1. 时间复杂度是O(n^2)

2. 空间复杂度是O(1)

## Javascript 代码实现

```js
function selectionSort(arr) {
    const length = arr.length
    let minIndex, temp

    for(let i = 0; i < length - 1; i++) {
        minIndex = i
        for (let j = i + 1; j < length; j++) {
            if (arr[j] < arr[minIndex]) {
                minIndex = j
            }
        }

        temp = arr[i]
        arr[i] = arr[minIndex]
        arr[minIndex] = temp
    }

    return arr
}
```

## Go代码实现

```go
func selectionSort(arr []int) []int {
	length := len(arr)
	for i := 0; i < length-1; i++ {
		minIndex := i
		for j := i + 1; j < length; j++ {
			if arr[j] < arr[minIndex] {
				minIndex = j
			}
		}

		arr[minIndex], arr[i] = arr[i], arr[minIndex]
	}

	return arr
}
```

## 选择排序与冒泡排序的区别

冒泡排序通过依次交换相邻两个顺序不合法的元素位置，从而将当前最小（大）元素放到合适的位置；而选择排序每遍历一次都记住了当前最小（大）元素的位置，最后仅需一次交换操作即可将其放到合适的位置。
