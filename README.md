# Parley

Parley is a lightweight dialogue system for nanos world packages. It loads simple dialogue scripts, runs them per-player, and drives a WebUI by default.

This project is inspired by the Godot Dialogue Manager (GDM): https://github.com/nathanhoad/godot_dialogue_manager

Documentation: https://MaxSC4.github.io/parley/

## Quickstart (5 minutes)

1) Clone into your server packages:

```powershell
cd Server\Packages
git clone https://github.com/MaxSC4/parley.git Parley
```

2) Enable in `Config.toml`:

```toml
packages = [
  "Parley"
]
```

3) Start the server and run the demo command:

```text
parley
```

This opens the default WebUI dialogue for all connected players.

For the full walkthrough and more examples, see the docs site.

