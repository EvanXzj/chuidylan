# Invalid memory address or nil pointer dereference

**Why does this program panic?**

```go
package main

import (
    "math"
    "fmt"
)

type Point struct {
    X, Y float64
}

func (p *Point) Abs() float64 {
    return math.Sqrt(p.X*p.X + p.Y*p.Y)
}

func main() {
    var p *Point
    fmt.Println(p.Abs())
}
```

```
panic: runtime error: invalid memory address or nil pointer dereference
[signal SIGSEGV: segmentation violation code=0x1 addr=0x0 pc=0x499043]

goroutine 1 [running]:
main.(*Point).Abs(...)
	/tmp/sandbox466157223/prog.go:13
main.main()
	/tmp/sandbox466157223/prog.go:18 +0x23
```

## Answer

**The uninitialized pointer p in the main function is nil, and you can’t follow the nil pointer.**

> If x is nil, an attempt to evaluate *x will cause a run-time panic.
> 
> — [The Go Programming Language Specification: Address operators](https://golang.org/ref/spec#Address_operators)

You need to create a Point

```go
func main() {
    var p *Point = new(Point)
    fmt.Println(p.Abs())
}
```

Since methods with pointer receivers take either a value or a pointer, you could also skip the pointer altogether:

```go
func main() {
    var p Point // has zero value Point{X:0, Y:0}
    fmt.Println(p.Abs())
}
```