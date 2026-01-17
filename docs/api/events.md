# Events

Parley uses events to connect Lua and WebUI. This keeps the UI replaceable.

## Do this first: see the event flow

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

Parley.Start(player, asset, { entry = "start" })
```

### What happens in-game
The server emits `Parley:show_line` and the client WebUI shows it.

## Event list
Lua to WebUI:
- `Parley:show_line`
- `Parley:show_choices`
- `Parley:hide`

WebUI to Lua:
- `Parley:choose`
- `Parley:next`
- `Parley:close`

## What's next?
In the next section, we will look at the default UI.
