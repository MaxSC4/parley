# Choices and Branching

Choices are lines starting with `-` or `*`. They let the player decide what happens next.

## Do this first: a choice example

### Dialogue file
```text
start:
System: Pick a path.
- Path A. -> a
- Path B. -> b

a:
System: You picked A.
end

b:
System: You picked B.
end
```

### Lua code
```lua
local Parley = require("parley/core.lua")

local asset = Parley.Load([[start:
System: Pick a path.
- Path A. -> a
- Path B. -> b

a:
System: You picked A.
end

b:
System: You picked B.
end
]], { is_string = true })

Parley.Start(player, asset, { entry = "start" })
```

### What happens in-game
The player sees two choices. Clicking either one shows a different line, then ends.

## What's next?
In the next section, we will add conditions.
