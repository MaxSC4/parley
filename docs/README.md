# Parley Documentation

Parley is a plug-and-play branching dialogue system for nanos world. It focuses on a small DSL, a stateless runtime, and a replaceable UI.

## What It Solves
- Simple branching dialogues without hardcoded game mechanics.
- A clean runtime that delegates state to your game code.
- A default WebUI that you can fully replace.

## Minimal Example
```lua
local Parley = require("parley/core.lua")
local asset = Parley.Load([[start:
Narrator: Hello.
end
]], { is_string = true })
Parley.Start(player, asset, { entry = "start" })
```

## Start Here
Read the Getting Started guide: `getting-started/installation.md`.

<!-- SCREENSHOT: Default Parley dialogue UI -->
![Parley Default UI](_assets/images/placeholders/ui-default.png)

## Authoring Rules
Each documentation page must:
- Start with a short explanation.
- Include at least one code example.
- Include placeholders for visuals when relevant.
- Avoid game-specific assumptions.
- Be written for intermediate scripters.
