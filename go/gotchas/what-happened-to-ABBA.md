# What happened to ABBA?

### What’s up with strings.TrimRight?

```go
fmt.Println(strings.TrimRight("ABBA", "BA")) // Output: ""
```

### Answer
The Trim, TrimLeft and TrimRight functions strip all Unicode code points contained in a **cutset**. In this case, all trailing A:s and B:s are stripped from the string, leaving the empty string.

To strip a trailing string, use **strings.TrimSuffix**.

```go
fmt.Println(strings.TrimSuffix("ABBA", "BA")) // Output: "AB"
```