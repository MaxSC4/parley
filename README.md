# Parley

A plug'n'play branching dialogue system for nanos world. Inspired by the script-like philosophy of Godot Dialogue Manager, but implemented in Lua with a stateless runtime and a replaceable UI.

## Install
1) Drop this folder into `Packages/parley`.
2) Start your server.
3) Call `Parley.Load` and `Parley.Start`.

## Quick Start (under 10 lines)
```lua
local Parley = require("parley/core")
local asset = Parley.Load("Packages/parley/Examples/dialogues/Minimal.txt")
Parley.RegisterStateProvider(function(player) return { get = function(_, path) return nil end } end)
Parley.Start(player, asset, { entry = "start" })
```

## 5-Minute Tutorial
1) Create a dialogue file using the DSL (see `docs/FILE_FORMAT.md`).
2) Load it once with `Parley.Load` and keep the asset.
3) Register a state provider to expose game data and actions.
4) Start a session for a player.
5) Let the default WebUI handle the display.

## API Overview
- `Parley.Load(path_or_string, opts) -> DialogueAsset`
- `Parley.Start(player_or_nil, asset_or_id, opts) -> session_id`
- `Parley.Stop(player_or_nil, session_id, reason)`
- `Parley.IsRunning(player_or_nil) -> bool`
- `Parley.RegisterStateProvider(fn(player) -> provider)`
- `Parley.SetTextResolver(fn(player, ctx, template) -> string)`
- `Parley.SetUIAdapter(adapter)`

Full details: `docs/API.md`

## Examples
- `Examples/MinimalStart.lua`
- `Examples/StateProviderExample.lua`
- `Examples/CustomUIAdapterExample.lua`

## Docs
- `docs/FILE_FORMAT.md`
- `docs/API.md`
- `docs/INTEGRATION.md`




