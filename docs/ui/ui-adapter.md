# UI Adapter Interface

The adapter is the bridge between Parley and your UI. It receives steps and shows them however you like.

## Do this first: a tiny adapter

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

local adapter = {
  show_line = function(player, line)
    print("LINE: " .. line.text)
  end,
  show_choices = function(player, choices)
    for _, c in ipairs(choices) do
      print("CHOICE: " .. c.text)
    end
  end,
  hide = function(player)
    print("HIDE")
  end
}

Parley.SetUIAdapter(adapter)
Parley.Start(player, asset, { entry = "start" })
```

### What happens in-game
The UI does not show, but you see output in the console. This proves the adapter is working.

## What's next?
In the next section, we will build a custom UI step by step.
