# Server Authoritative Model

The server owns dialogue flow and state resolution.

## Example
```lua
Parley.RegisterStateProvider(function(player)
  return { get = function(_, path) return nil end }
end)
```
