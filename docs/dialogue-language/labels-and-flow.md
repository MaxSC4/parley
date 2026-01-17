# Labels and Flow

Labels are named entry points. `goto` moves you to another label, and `end` finishes the session.

## Do this first: a flow example

### Dialogue file
```text
start:
System: First step.
goto step_two

step_two:
System: Second step.
end
```

### Lua code
```lua
local Parley = require("parley/core.lua")

local asset = Parley.Load([[start:
System: First step.
goto step_two

step_two:
System: Second step.
end
]], { is_string = true })

Parley.Start(player, asset, { entry = "start" })
```

### What happens in-game
The player sees the first line, then immediately the second line, then the dialogue ends.

<!-- IMAGE: Branching example -->
![Branching](../_assets/images/placeholders/branching-example.png)

## What's next?
In the next section, we will explore choices and branching.
