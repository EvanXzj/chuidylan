# Assignment to entry in nil map

__Why does this program panic?__

```go
var m map[string]float64
m["pi"] = 3.1416
```

```sh
# Output
panic: assignment to entry in nil map
```

## Answer

__You have to initialize the map using the make function (or a map literal) before you can add any elements:__

```go
m := make(map[string]float64)
m["pi"] = 3.1416
```