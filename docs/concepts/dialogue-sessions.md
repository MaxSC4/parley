# Dialogue Sessions

A session is the tiny bit of runtime state Parley keeps. It tracks which label and line a player is on.

## Do this first: start a session

### Dialogue file
```text
start:
System: Session started.
- End. -> end
```

### Lua code
```lua
local Parley = require("parley/core.lua")

local asset = Parley.Load([[start:
System: Session started.
- End. -> end
]], { is_string = true })

local session_id = Parley.Start(player, asset, { entry = "start" })
```

### What happens in-game
The player sees one line and ends the dialogue. The session ends when the dialogue ends.

## What's next?
In the next section, we will build a state provider and use it for conditions.
