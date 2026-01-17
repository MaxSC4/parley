# Callbacks

Callbacks let you hook into dialogue progress. They are optional, but very useful for logging and game logic.

## Do this first: a callback example

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

Parley.Start(player, asset, {
  entry = "start",
  on_line = function(p, line)
    print("Line shown: " .. line.text)
  end,
  on_end = function(p, reason)
    print("Ended: " .. tostring(reason))
  end
})
```

### What happens in-game
The player sees the line. Your console logs the line and the end reason.

## What's next?
In the next section, we will cover UI events.
