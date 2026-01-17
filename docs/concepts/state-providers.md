# State Providers

A state provider is how Parley reads and applies game state. It keeps the dialogue system clean and generic.

## Do this first: a state-driven example

### Dialogue file
```text
start:
System: Hello {{player.name}}.
if flags.met == true: System: We have met before.
- End. -> end
```

### Lua code
```lua
local Parley = require("parley/core.lua")

local asset = Parley.Load([[start:
System: Hello {{player.name}}.
if flags.met == true: System: We have met before.
- End. -> end
]], { is_string = true })

Parley.RegisterStateProvider(function(player)
  return {
    get = function(_, path)
      if path == "player.name" then
        return player:GetName()
      end
      if path == "flags.met" then
        return player:GetValue("parley_met") or false
      end
      return nil
    end,
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
The player sees a greeting and an extra line if the flag is set.

<!-- DIAGRAM: StateProvider interaction -->

## What's next?
In the next section, we will look at the dialogue language itself.
