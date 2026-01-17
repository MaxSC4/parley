# First Dialogue

Let's build a first dialogue and explain each line. You will see exactly what the player sees.

## Do this first: the full example

### Dialogue file
```text
start:
Guide: Welcome to the demo.
- Continue. -> step_two

step_two:
Guide: You made it to the second step.
- End. -> end
```

### Lua code
```lua
local Parley = require("parley/core.lua")

local asset = Parley.Load([[start:
Guide: Welcome to the demo.
- Continue. -> step_two

step_two:
Guide: You made it to the second step.
- End. -> end
]], { is_string = true })

Parley.Start(player, asset, { entry = "start" })
```

### What happens in-game
The player sees the first line, clicks Continue, then sees the second line and ends the dialogue.

<!-- IMAGE: Simple dialogue flow diagram -->
![Dialogue Flow](../_assets/images/placeholders/dialogue-flow.png)

## Why this works
Labels like `start:` and `step_two:` define where the dialogue goes next. Choices move between labels.

## What's next?
In the next section, we will explain Parley's core philosophy.
