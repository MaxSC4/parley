# Dialogue Language Overview

The Parley DSL is a small, readable script format. It is not a programming language. It is a way to describe dialogue steps.

## Do this first: a tiny DSL file

### Dialogue file
```text
start:
System: This is the DSL.
- End. -> end
```

### Lua code
```lua
local Parley = require("parley/core.lua")

local asset = Parley.Load([[start:
System: This is the DSL.
- End. -> end
]], { is_string = true })

Parley.Start(player, asset, { entry = "start" })
```

### What happens in-game
The player sees one line and ends the dialogue. The text file is all you need to describe the flow.

## What's next?
In the next section, we will look at the exact syntax rules.
