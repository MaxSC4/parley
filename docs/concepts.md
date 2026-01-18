# Concepts

Parley has three simple moving parts: a dialogue script, a runtime session, and a UI adapter.

## Dialogue scripts

Dialogue scripts are plain text files parsed by `Parley.Load`. They support:

- Labels like `start:`
- Lines like `Narrator: Hello.`
- Choices like `- Ask a question -> label`
- Conditions like `if player.reputation >= 2:`
- Actions like `do reputation += 1`

See the full syntax in [Dialogue Syntax](reference/dialogue-syntax.md).

## Sessions

`Parley.Start(player, asset)` creates a session per player. A session:

- Tracks the current label and step index.
- Evaluates conditions and actions.
- Emits steps (`line`, `choices`, `end`) to the UI adapter.

## UI adapter

The UI adapter is the bridge between Parley and whatever presentation you want:

- Default adapter uses WebUI and runs on the client.
- Custom adapters can print to console, drive Widgets, or integrate with your own WebUI.

The adapter interface is documented in [API Reference](reference/api.md).

## State provider

To use conditions or mutations, register a state provider:

- `get(ctx, path)` resolves `player.name` or `flags.met`
- `eval(ctx, expr)` optionally overrides expression evaluation
- `apply(ctx, action)` applies actions like `reputation += 1`

See [State and Conditions](guides/state-and-conditions.md) for a working example.

