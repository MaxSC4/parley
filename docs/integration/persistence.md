# Persistence and Save Data

Parley does not save game state. That is your job, and that is a good thing.

## Do this first: store a simple flag

### Dialogue file
```text
start:
System: Saving a flag.
do flags.met = true
- End. -> end
```

### Lua code
```lua
local Parley = require("parley/core.lua")

local asset = Parley.Load([[start:
System: Saving a flag.
do flags.met = true
- End. -> end
]], { is_string = true })

Parley.RegisterStateProvider(function(player)
  return {
    apply = function(_, action)
      if action == "flags.met = true" then
        player:SetValue("parley_met", true)
      end
    end
  }
end)

Parley.Start(player, asset, { entry = "start" })
```

### What happens in-game
The dialogue runs and your game stores the flag. You can load it later from your own system.

## What's next?
In the next section, we will look at complete examples.
