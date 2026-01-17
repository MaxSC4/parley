# Variables and Interpolation

Interpolation lets you insert values into dialogue text using `{{ }}`.

## Do this first: a personalized line

### Dialogue file
```text
start:
System: Hello {{player.name}}.
- End. -> end
```

### Lua code
```lua
local Parley = require("parley/core.lua")

local asset = Parley.Load([[start:
System: Hello {{player.name}}.
- End. -> end
]], { is_string = true })

Parley.RegisterStateProvider(function(player)
  return {
    get = function(_, path)
      if path == "player.name" then
        return player:GetName()
      end
      return nil
    end
  }
end)

Parley.Start(player, asset, { entry = "start" })
```

### What happens in-game
The player sees their name in the text.

## What's next?
In the next section, we will discuss error handling.
