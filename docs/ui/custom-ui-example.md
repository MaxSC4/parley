# Custom UI Example

This page shows a simple custom UI setup. You can replace the default WebUI completely.

## Do this first: wire a custom adapter

### Dialogue file
```text
start:
System: Hello.
- End. -> end
```

### Lua code
```lua
local Parley = require("parley/core.lua")

local asset = Parley.Load([[start:
System: Hello.
- End. -> end
]], { is_string = true })

local adapter = {
  show_line = function(player, line) end,
  show_choices = function(player, choices) end,
  hide = function(player) end
}

Parley.SetUIAdapter(adapter)
Parley.Start(player, asset, { entry = "start" })
```

### What happens in-game
Nothing appears because your adapter is empty. This is a good place to plug your own UI.

## What's next?
In the next section, we will integrate Parley with nanos world flow.
