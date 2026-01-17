# Syntax

This page explains how the DSL is laid out. It is line-based and intentionally simple.

## Do this first: syntax in action

### Dialogue file
```text
# A comment line
start:
System: Hello.
- End. -> end
```

### Lua code
```lua
local Parley = require("parley/core.lua")

local asset = Parley.Load([[# A comment line
start:
System: Hello.
- End. -> end
]], { is_string = true })

Parley.Start(player, asset, { entry = "start" })
```

### What happens in-game
Comments are ignored. The player sees the line and ends the dialogue.

## What's next?
In the next section, we will cover labels and flow control.
