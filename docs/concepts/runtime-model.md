# Runtime Model

Parley flows as: parse -> runtime -> UI.

## Lifecycle
1) Parse dialogue.
2) Start session.
3) Emit line/choices/end steps.

<!-- DIAGRAM: Runtime pipeline -->
![Runtime Model](../_assets/images/placeholders/state-provider-diagram.png)

## Example
```lua
local step = Engine.Next(session, provider, resolver)
```
