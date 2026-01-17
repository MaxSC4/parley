# Error Handling

Parser errors include file, line, and snippet.
Runtime errors include session and label.

## Example
```lua
local ok, err = pcall(Parley.Load, "bad.txt")
```
