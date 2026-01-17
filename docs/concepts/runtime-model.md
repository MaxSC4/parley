# Runtime Model

Parley follows a simple flow: parse, run, display. This keeps the runtime predictable and easy to debug.

## Do this first: a full example

### Dialogue file
```text
start:
System: One line, one step.
- End. -> end
```

### Lua code
```lua
local Parley = require("parley/core.lua")

local asset = Parley.Load([[start:
System: One line, one step.
- End. -> end
]], { is_string = true })

Parley.Start(player, asset, { entry = "start" })
```

### What happens in-game
Parley parses the text into steps, then the runtime emits one step at a time to the UI.

<!-- DIAGRAM: Runtime pipeline -->
![Runtime Model](../_assets/images/placeholders/state-provider-diagram.png)

## What's next?
In the next section, we will talk about dialogue sessions per player.
