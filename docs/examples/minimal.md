# Example: Minimal Start

This is the default demo wired in `Server/Index.lua`.

## Dialogue script

`Examples/dialogues/Minimal.txt`:

```text
start:
Narrator: Welcome to Parley.
- Who are you? -> who
- Goodbye. -> end

who:
Narrator: Just a guide.
end
```

## Starter script

`Examples/MinimalStart.lua`:

```lua
local Parley = require("parley/core.lua")

local asset = Parley.Load([[start:
Narrator: Welcome, {{player.name}}.
...
]], { is_string = true, cache = true })

function MinimalStart.StartFor(player)
    Parley.Start(player, asset, { entry = "start" })
end
```

To trigger it, run the server console command:

```
parley
```

