# Why doesn’t append work every time?

**What’s up with the append function?**

```go
a := []byte("ba")

a1 := append(a, 'd')
a2 := append(a, 'g')

fmt.Println(string(a1)) // bag
fmt.Println(string(a2)) // bag
```

**Answer**

If there is room for more elements, append reuses the underlying array. Let's take a look:

```go
a := []byte("ba")
fmt.Println(len(a), cap(a)) // 2 32
```

This means that the slices **a, a1 and a2** will refer to the **same underlying array** in our example.

To avoid this, we need to use two separate byte arrays.

```go
const prefix = "ba"

a1 := append([]byte(prefix), 'd')
a2 := append([]byte(prefix), 'g')

fmt.Println(string(a1)) // bad
fmt.Println(string(a2)) // bag
```
