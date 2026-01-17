# State-driven Dialogue

This example uses conditions and actions.

## Dialogue
```
if player.reputation >= 1: Narrator: Welcome back.
do reputation += 1
```

## Lua
```lua
Parley.RegisterStateProvider(function(player)
  return {
    get = function(_, path) return nil end,
    apply = function(_, action) end
  }
end)
```
