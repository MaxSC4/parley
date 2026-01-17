# FAQ

This page answers a few common questions.

## Do this first: a quick example

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
The dialogue appears and ends. This is the smallest visible result.

## Can I pause a dialogue?
Yes. Stop the session and store your own state. You can resume later by starting at a different label.

## Can I reuse dialogues?
Yes. Parse once and start multiple sessions.

## Is it multiplayer-safe?
Yes. Each player has their own session.

## Localization?
Use a custom text resolver to map keys to localized strings.

## What's next?
If you want a deeper dive, go back to the Dialogue Language section and explore the pages there.
