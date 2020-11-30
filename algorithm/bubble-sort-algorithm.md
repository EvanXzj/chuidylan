# 冒泡排序

冒泡排序(Bubble Sort), 是一种计算机科学领域的比较简单的排序算法，也是程序猿们在面试中常被问的排序算法之一。

## 算法描述

它重复地走访过要排序的元素列，一次比较两个相邻的元素，如果他们的顺序（如从大到小、首字母从A到Z）错误就把他们交换过来。走访元素的工作就是重复地进行直到没有相邻元素需要交换，也就是说该元素已经排序完成。

这个算法的名字由来是因为越大的元素会经由交换慢慢“浮”到数列的顶端（升序或降序排列），就如同碳酸饮料中二氧化碳的气泡最终会上浮到顶端一样，故名“冒泡排序”。

## 算法步骤

    1. 比较相邻的两个元素。 升序，如果第一个比第二大就交换两个元素，降序则反之。

    2. 对每一对相邻元素作同样的工作，从开始第一对到结尾的最后一对。执行完这步则认为最后一个数已排序。

    3. 针对所有的元素重复以上的步骤，除了最后一个。

    4. 对剩余未排序的数重复上面的步骤，直到没有任何一对数字需要比较。

## 动图演示

![bubble sort](https://github.com/EvanXzj/JS-Sorting-Algorithm/raw/master/res/bubbleSort.gif)

> 图片源自GitHub

## 算法复杂度

    1. 名词解释

        - 时间复杂度(Time Complexity)：是一个函数，它定性描述了该算法的运行时间，记做T(n) = O(fn(n))

        - 空间复杂度(Space Complexity): 是对一个算法在运行过程中临时占用存储空间大小的量度，记做S(n) = O(f(n))

    2. 冒泡排序时间复杂度： O(n^2)

    3. 冒泡排序空间复杂度：O(1)

## Javascript 代码实现

```javascript
function bubbleSort(arr) {
    const len = arr.length
    for(let i = 0; i < len - 1; i++) {
        for(let j = 0; j < len - i - 1; j++) {
            if (arr[j] > arr[j+1]) {
                const temp = arr[j+1]
                arr[j+1] = arr[j]
                arr[j] = temp
            }
        }
    }

    return arr
}
```

## Go代码实现

```go
func bubbleSort(arr []int) []int {
	length := len(arr)
	for i := 0; i < length-1; i++ {
		for j := 0; j < length-i-1; j++ {
			if arr[j] > arr[j+1] {
				arr[j+1], arr[j] = arr[j], arr[j+1]
			}
		}
	}

	return arr
}
```
