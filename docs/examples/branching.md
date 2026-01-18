# Example: Branching + Reputation

This example combines conditions and mutations.

## Dialogue script

`Examples/dialogues/Branching.txt`:

```text
start:
Narrator: Hello, {{player.name}}.
if player.reputation >= 5: Narrator: People speak highly of you.
- Ask about the town. -> town
- Leave. -> end

town:
Narrator: The town is quiet these days.
do reputation += 1
- Thanks. -> end
```

## State provider

`Examples/StateProviderExample.lua`:

```lua
Parley.RegisterStateProvider(function(player)
    return {
        get = function(_, path)
            if path == "player.name" then
                return player:GetName()
            end
            if path == "player.reputation" then
                return player:GetValue("reputation") or 0
            end
        end,
        apply = function(_, action)
            if action == "reputation += 1" then
                player:SetValue("reputation", (player:GetValue("reputation") or 0) + 1)
            end
        end
    }
end)
```

Trigger it by running `/branch` in chat (see the example file for the full command hook).

