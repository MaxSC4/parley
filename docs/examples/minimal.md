# Minimal Dialogue

This is the smallest useful example.

## Do this first: the complete example

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
The player sees one line and ends the dialogue.

## What's next?
In the next section, we will add branching choices.
