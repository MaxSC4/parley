# Guide: Your First Dialogue File

Start with a file-based dialogue and a chat command to launch it.

## 1) Create a dialogue file

Create `Packages/Parley/Examples/dialogues/MyFirst.txt`:

```text
start:
Narrator: Hello, {{player.name}}.
- Who are you? -> who
- Goodbye. -> end

who:
Narrator: I am the Parley guide.
end
```

## 2) Load and start it

Add this to `Server/Index.lua` (or a new file you require from there):

```lua
local Parley = require("parley/core.lua")

local asset = Parley.Load("Packages/Parley/Examples/dialogues/MyFirst.txt", { cache = true })

Events.Subscribe("ChatCommand", function(player, command)
    if command == "/mydialogue" then
        Parley.Start(player, asset, { entry = "start" })
    end
end)
```

## 3) Try it in game

Join your server, open chat, and run:

```
/mydialogue
```

You should see the Parley UI with your new lines.

