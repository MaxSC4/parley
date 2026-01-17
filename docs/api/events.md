# Events

## Lua -> WebUI
- `Parley:show_line`
- `Parley:show_choices`
- `Parley:hide`

## WebUI -> Lua
- `Parley:choose`
- `Parley:next`
- `Parley:close`

## Example
```lua
Events.CallRemote("Parley:show_line", player, id, speaker, text, meta)
```
