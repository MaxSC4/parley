# nanos world

Parley runs on the server and uses events to update the client UI. This keeps the logic authoritative and predictable.

## Do this first: a simple server call

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
The server advances the dialogue. The client receives UI events.

## What's next?
In the next section, we will discuss the server-authoritative model.
