# Actions

Actions let your game code run side effects when the dialogue reaches a line.

## Do this first: an action example

### Dialogue file
```text
start:
System: Thanks for helping.
do flags.met = true
- End. -> end
```

### Lua code
```lua
local Parley = require("parley/core.lua")

local asset = Parley.Load([[start:
System: Thanks for helping.
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
The line shows, then your provider sets a flag. The player can end the dialogue.

## What's next?
In the next section, we will use variables and interpolation.
