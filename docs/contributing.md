# Contributing

Thanks for helping improve Parley.

## Local setup

1) Clone the repo into your `Server/Packages` folder.
2) Enable it in `Config.toml`.
3) Start the server and use `parley` to validate behavior.

## Code style

Lua style is checked with `luacheck` and `.luacheckrc`.

On Windows, you can run:

```powershell
tools\luacheck\luacheck.exe -c .luacheckrc Shared Server Client Examples Tests
```

## Tests

There is a lightweight parser check at `Tests/ParserTest.lua`.

To run it, temporarily require it from `Server/Index.lua` in a dev branch or run it through your own test harness.

## Pull requests

- Keep changes focused.
- Update docs when behavior changes.
- Add a minimal example if you introduce new syntax.

