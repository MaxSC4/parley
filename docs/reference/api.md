# API Reference

This reference covers the public surface of `Shared/parley/core.lua` and related interfaces.

## Module: Parley

### `Parley.RegisterStateProvider(fn)`

Registers a per-player state provider.

`fn(player)` must return a table with any of:

- `get(ctx, path)` -> value
- `eval(ctx, expr)` -> boolean (optional override)
- `apply(ctx, action)` -> void

### `Parley.SetTextResolver(fn)`

Overrides the template resolver used to expand `{{path}}` tokens in lines and choices.

Signature: `fn(player, ctx, template) -> string`

### `Parley.SetUIAdapter(adapter)`

Sets the UI adapter used to display steps.

Adapter shape:

- `show_line(player, line, session)`
- `show_choices(player, choices, session)`
- `hide(player, session)`

### `Parley.Load(path_or_string, opts)`

Parses dialogue into an asset.

`opts`:

- `is_string` (bool): treat `path_or_string` as raw text
- `file` (string): virtual filename for error reporting
- `id` (string): store in asset cache under this id
- `cache` (bool): cache by `path_or_string`

Returns the asset table.

### `Parley.Start(player, asset_or_id, opts)`

Starts a new session for `player`.

`asset_or_id` can be:

- an asset table returned by `Parley.Load`
- a cached id used in `Parley.Load`

`opts`:

- `entry` (string): label to start from (default `start`)
- `context` (table): shared context passed to provider methods
- `on_line(player, line)` callback
- `on_choices(player, choices)` callback
- `on_choice_selected(player, choice)` callback
- `on_end(player, reason)` callback
- `on_error(player, error)` callback

Returns the session id.

### `Parley.Continue(player, session_id)`

Advances the session, emitting the next step.

### `Parley.SelectChoice(player, session_id, choice_id)`

Selects a choice and continues the session.

### `Parley.Stop(player, session_id, reason)`

Stops a session and closes the UI.

### `Parley.IsRunning(player)`

Returns `true` if a session is active for the player.

### `Parley.GetSession(session_id)`

Returns the session table (or `nil`).

### `Parley.GetAsset(asset_id)`

Returns a cached asset by id (or `nil`).

## Session object

Session fields:

- `id`, `player`, `asset`
- `label` (current label)
- `index` (next step index)
- `waiting_choices` (choices indexed by id)
- `opts` (options passed to Start)

## Step objects

Steps passed to adapters are:

- Line: `{ type = "line", speaker, text, meta }`
- Choices: `{ type = "choices", choices = { { id, text, target } } }`
- End: `{ type = "end", reason }`

