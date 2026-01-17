# Default UI

The default UI is a simple dialogue balloon with keyboard and mouse support.

## Do this first: show the UI

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

Parley.Start(player, asset, { entry = "start" })
```

### What happens in-game
The UI appears. You can click a choice or press Enter to continue.

<!-- SCREENSHOT: Default UI -->

## What's next?
In the next section, we will describe the UI adapter interface.
