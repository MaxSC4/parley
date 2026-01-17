# Philosophy

Parley is stateless. That means your game is always the source of truth. It keeps the system flexible and easy to integrate.

## Do this first: see it in action

### Dialogue file
```text
start:
System: This is a stateless dialogue.
- End. -> end
```

### Lua code
```lua
local Parley = require("parley/core.lua")

local asset = Parley.Load([[start:
System: This is a stateless dialogue.
- End. -> end
]], { is_string = true })

Parley.RegisterStateProvider(function(player)
  return { get = function(_, path) return nil end }
end)

Parley.Start(player, asset, { entry = "start" })
```

### What happens in-game
The player sees a single line and ends the dialogue. Parley never stores game data by itself.

## Why this matters
When you store state in your game code, you can reuse Parley with any system you already have.

## What's next?
In the next section, we will look at the runtime model step by step.
