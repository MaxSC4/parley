# Error Handling

Parley reports useful errors when parsing or running dialogue. This helps you fix problems fast.

## Do this first: catch a parse error

### Dialogue file
```text
start:
This line is invalid
```

### Lua code
```lua
local Parley = require("parley/core.lua")

local ok, err = pcall(function()
  Parley.Load([[start:
This line is invalid
]], { is_string = true })
end)

if not ok then
  print(err)
end
```

### What happens in-game
Nothing appears on screen. You see a clear error in the server log with file, line, and snippet.

## What's next?
In the next section, we will look at the Lua API.
