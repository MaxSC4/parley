![Screenshot: Parley UI](assets/screenshots/placeholder.png)

# Parley

Parley is a lightweight dialogue system for nanos world packages. It parses simple dialogue scripts, runs them per-player, and drives a WebUI by default so you can ship interactive conversations quickly.

This project is inspired by the Godot Dialogue Manager (GDM). If you want to see the roots of the format and philosophy, check the GDM repo: https://github.com/nathanhoad/godot_dialogue_manager

## What you can do quickly

- Load dialogue from a file or a string and start it for a player.
- Gate lines and choices with conditions.
- Apply mutations (actions) to game state.
- Swap the UI layer without touching your dialogue logic.

## The default flow

1) `Parley.Load` parses a dialogue script into an asset.
2) `Parley.Start` creates a session for a player and evaluates the first step.
3) The server UI adapter pushes steps to the client WebUI.
4) The client UI sends `next` or `choose` events back to the server.

Ready to see it in-game? Head to the 5-minute quickstart:

- [Quickstart](quickstart.md)

