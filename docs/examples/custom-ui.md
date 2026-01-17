# Custom UI Example

This example shows how to replace the default UI with your own adapter.

## Do this first: the full example

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
The UI is not shown. Instead, you see text output. This is where you plug your custom UI.

## What's next?
In the next section, we will answer common questions.
