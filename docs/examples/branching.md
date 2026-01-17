# Branching Dialogue

This example shows how choices branch the conversation.

## Do this first: the full example

### Dialogue file
```text
start:
System: Choose a branch.
- Left path. -> left
- Right path. -> right

left:
System: You chose left.
end

right:
System: You chose right.
end
```

### Lua code
```lua
local Parley = require("parley/core.lua")

local asset = Parley.Load([[start:
System: Choose a branch.
- Left path. -> left
- Right path. -> right

left:
System: You chose left.
end

right:
System: You chose right.
end
]], { is_string = true })

Parley.Start(player, asset, { entry = "start" })
```

### What happens in-game
The player sees two choices. Each choice leads to a different line.

<!-- SCREENSHOT: Dialogue showing multiple choices -->
![Dialogue Choices](../_assets/images/placeholders/branching-example.png)

## What's next?
In the next section, we will use state to change the dialogue.
