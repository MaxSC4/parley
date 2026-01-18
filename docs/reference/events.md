# Bridge Events

Parley uses nanos world Events to talk between server and client.

## Server -> Client (Remote)

Emitted by `Server/parley/serverbridge.lua`:

- `Parley:show_line` (session_id, speaker, text, meta)
- `Parley:show_choices` (session_id, choices)
- `Parley:hide` (session_id)

## Client -> Server (Remote)

Emitted by the WebUI and forwarded by `Client/parley/uiadapterdefault.lua`:

- `Parley:next` (session_id)
- `Parley:choose` (session_id, choice_id)
- `Parley:close` (session_id)

