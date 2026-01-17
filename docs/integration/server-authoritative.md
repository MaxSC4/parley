# Server Authoritative Model

The server owns the flow. The client is just a display and input layer.

## Do this first: a complete example

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
The server decides which line to show next. The client only renders it.

## What's next?
In the next section, we will connect Parley to persistence.
