# Custom UI Example

Replace the default UI with your own.

## Lua
```lua
local adapter = {
  show_line = function(player, line) end,
  show_choices = function(player, choices) end,
  hide = function(player) end
}
Parley.SetUIAdapter(adapter)
```
