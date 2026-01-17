# Quick Start

This is the 5-minute success path.

## Minimal Usage
```lua
local Parley = require("parley/core.lua")
local asset = Parley.Load([[start:
Narrator: Hello.
end
]], { is_string = true })
Parley.Start(player, asset, { entry = "start" })
```

## End Callback
```lua
Parley.Start(player, asset, {
  entry = "start",
  on_end = function(p, reason)
    print("Ended: " .. tostring(reason))
  end
})
```
