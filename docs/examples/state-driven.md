# State-driven Dialogue

This example uses conditions and actions to change what the player sees.

## Do this first: the full example

### Dialogue file
```text
start:
System: Hello.
if flags.met == true: System: Welcome back.
- End. -> end
```

### Lua code
```lua
local Parley = require("parley/core.lua")

local asset = Parley.Load([[start:
System: Hello.
if flags.met == true: System: Welcome back.
- End. -> end
]], { is_string = true })

Parley.RegisterStateProvider(function(player)
  return {
    get = function(_, path)
      if path == "flags.met" then
        return player:GetValue("parley_met") or false
      end
      return nil
    end
  }
end)

Parley.Start(player, asset, { entry = "start" })
```

### What happens in-game
If the flag is true, the player sees an extra line. Otherwise, they do not.

## What's next?
In the next section, we will swap in a custom UI.
