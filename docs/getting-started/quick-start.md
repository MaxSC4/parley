# Quick Start

Let's get something on screen fast. This example is tiny but complete.

## Do this first: a working dialogue

### Dialogue file
```text
start:
System: Hello.
- Continue. -> end
```

### Lua code
```lua
local Parley = require("parley/core.lua")

local asset = Parley.Load([[start:
System: Hello.
- Continue. -> end
]], { is_string = true })

Parley.Start(player, asset, { entry = "start" })
```

### What happens in-game
The player sees a single line and a choice that ends the dialogue.

## Why we use an inline string
Using `is_string = true` avoids unsafe file access. If you want to load a file instead, pass a path and start the server with `--enable_unsafe_libs`.

## What's next?
In the next section, we will build a first dialogue and explain it line by line.
