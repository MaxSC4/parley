# Minimal Dialogue

A minimal example with one line.

## Dialogue
```
start:
Narrator: Hello.
end
```

## Lua
```lua
local asset = Parley.Load([[start:
Narrator: Hello.
end
]], { is_string = true })
Parley.Start(player, asset, { entry = "start" })
```
