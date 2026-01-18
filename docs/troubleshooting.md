# Troubleshooting

## The UI does not appear

- Confirm the package is enabled in `Config.toml`.
- Ensure you ran the `parley` server console command.
- Make sure the client loads the package (it must be listed under `packages`).
- On Linux, check case sensitivity for `Parley` vs `parley`.

## "Parley UI adapter not set"

This means `Parley.SetUIAdapter` was not called. The default server entry point does this via:

- `Server/Index.lua` -> `Server/parley/serverbridge.lua`

If you replaced `Server/Index.lua`, re-add the adapter setup.

## "Parley.Start unknown asset id"

You called `Parley.Start(player, "my-id")` but never cached it.

Fix: use `Parley.Load(..., { id = "my-id", cache = true })` or pass the asset table directly.

## "Parley missing label"

The dialogue references a label that does not exist.

Fix: verify your `-> label` targets and `goto label` lines.

## Conditions always fail

If you rely on `player.something`, you must implement `get` in your state provider.

Check your `Parley.RegisterStateProvider` logic and confirm the paths match.

