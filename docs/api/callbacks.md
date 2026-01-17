# Callbacks

Callbacks are optional and run during the session.

## Example
```lua
Parley.Start(player, asset, {
  on_line = function(p, line) end,
  on_choices = function(p, choices) end,
  on_end = function(p, reason) end
})
```
