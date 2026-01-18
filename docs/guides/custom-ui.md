# Guide: Custom UI

Parley ships with a WebUI-based UI adapter. You can customize it or swap it entirely.

## Option A: Skin the default WebUI

The default WebUI lives here:

- `Client/ui/parleyui/index.html`
- `Client/ui/parleyui/style.css`
- `Client/ui/parleyui/app.js`

You can change layout, colors, and keybindings safely inside those files.

Useful default keybindings from `app.js`:

- Enter / Space: continue
- Arrow keys: change selection
- Escape: close

## Option B: Provide your own adapter

Adapters are simple tables with three functions:

```lua
local custom_adapter = {
    show_line = function(player, line)
        print(("[Parley Custom UI] %s: %s"):format(line.speaker or "", line.text or ""))
    end,
    show_choices = function(player, choices)
        for _, choice in ipairs(choices) do
            print("[Choice] " .. choice.text)
        end
    end,
    hide = function(player)
        print("[Parley Custom UI] Closed")
    end
}

Parley.SetUIAdapter(custom_adapter)
```

The example above is fully server-side and matches `Examples/CustomUIAdapterExample.lua`.

## Option C: Bridge to your own WebUI

If you already have a custom WebUI, you can send the steps to it from the server and handle the UI on the client, exactly like the built-in adapter does.

See these files for the pattern:

- `Server/parley/serverbridge.lua`
- `Client/parley/clientbridge.lua`
- `Client/parley/uiadapterdefault.lua`

