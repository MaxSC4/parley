# Philosophy

Parley is stateless by design. The game owns all state.

## Core Ideas
- The parser produces a reusable asset.
- The runtime advances one step at a time.
- The UI is replaceable and optional.

## Example
```lua
Parley.RegisterStateProvider(function(player)
  return { get = function(_, path) return nil end }
end)
```
