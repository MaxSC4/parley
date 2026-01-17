# Custom UI Example

This example disables the default UI and installs a custom adapter.

## Example
```lua
local adapter = {
  show_line = function(player, line) end,
  show_choices = function(player, choices) end,
  hide = function(player) end
}
Parley.SetUIAdapter(adapter)
```
