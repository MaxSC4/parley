# State Providers

State providers expose game data and apply actions.

## Interface
```lua
Parley.RegisterStateProvider(function(player)
  return {
    get = function(_, path) return nil end,
    eval = function(_, expr) return true end,
    apply = function(_, action) end
  }
end)
```

<!-- DIAGRAM: StateProvider interaction -->
