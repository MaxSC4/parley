# Lua API

This page shows the main functions you will use. We will keep it friendly and practical.

## Do this first: a complete call

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

local session_id = Parley.Start(player, asset, { entry = "start" })
```

### What happens in-game
The player sees one line, then ends the dialogue. You also get a session id.

## Key functions
- `Parley.Load(path_or_string, opts)`
- `Parley.Start(player_or_nil, asset_or_id, opts)`
- `Parley.Stop(player_or_nil, session_id, reason)`
- `Parley.IsRunning(player_or_nil)`
- `Parley.RegisterStateProvider(fn)`
- `Parley.SetTextResolver(fn)`
- `Parley.SetUIAdapter(adapter)`

## What's next?
In the next section, we will explore callbacks.
