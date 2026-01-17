# Parley Documentation

Welcome. Parley is a plug-and-play branching dialogue system for nanos world. It is built to be small, clear, and easy to replace when you want your own UI.

## Do this first: a tiny working dialogue

### Dialogue file
```text
start:
System: Hello there.
- Continue. -> continue
- Exit. -> end

continue:
System: You reached the next step.
end
```

### Lua code
```lua
local Parley = require("parley/core.lua")

local asset = Parley.Load([[start:
System: Hello there.
- Continue. -> continue
- Exit. -> end

continue:
System: You reached the next step.
end
]], { is_string = true })

Parley.Start(player, asset, { entry = "start" })
```

### What happens in-game
When this runs, the player sees a small dialog with two choices. Clicking a choice moves the dialogue forward or ends it.

<!-- SCREENSHOT: Default Parley dialogue UI -->
![Parley Default UI](_assets/images/placeholders/ui-default.png)

## Why this exists
Parley keeps state in your game code, not in the dialogue system. That keeps your dialogue logic flexible and easy to replace.

## What's next?
In the next section, we will install Parley and verify it loads.
