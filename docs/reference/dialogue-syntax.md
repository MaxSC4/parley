# Dialogue Syntax

Parley dialogue is plain text. It is parsed by `Shared/parley/parser/parser.lua`.

## Labels

Labels define entry points:

```text
start:
intro:
```

If no label appears before the first line, Parley creates `start` automatically.

## Lines

```text
Narrator: Welcome to Parley.
```

The part before `:` is the speaker, the rest is the text.

## Choices

Choices start with `-` or `*`:

```text
- Ask a question -> who
- Goodbye. -> end
```

Targets after `->` are optional. If a target is omitted, the dialogue continues normally.

## Jumps

```text
goto options
```

## End

```text
end
```

## Conditions

Conditions can prefix any line or choice:

```text
if player.reputation >= 2: Narrator: We have met before.
when flags.met == true: - Special option -> secret
```

The built-in expression evaluator supports:

- `and`, `or`, `not`
- `==`, `!=`, `<`, `<=`, `>`, `>=`
- numbers, quoted strings, booleans
- identifiers like `player.name` (resolved by your state provider)

## Actions

Actions are executed through your state provider:

```text
do reputation += 1
set flags.met = true
```

Parley passes the full action string to `provider.apply(ctx, action)`.

## Template variables

`{{path}}` tokens are replaced in line and choice text:

```text
Narrator: Hello, {{player.name}}.
```

By default, paths are resolved via `provider.get(ctx, path)`.

## Comments

Lines starting with `#` or `//` are ignored.

