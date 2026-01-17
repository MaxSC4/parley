# UI Adapter Interface

Adapters bridge Parley steps to your UI.

## Interface
```lua
local adapter = {
  show_line = function(player, line, session) end,
  show_choices = function(player, choices, session) end,
  hide = function(player, session) end
}
```
