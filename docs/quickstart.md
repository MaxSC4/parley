# Quickstart (5 minutes)

Goal: load Parley, start a dialogue, and see it on screen.

The steps below match the current package structure and the code in `Server/Index.lua` and `Examples/MinimalStart.lua`.

## Step 1: Install the package

From your nanos world server folder:

```powershell
cd Server\Packages
git clone https://github.com/MaxSC4/parley.git Parley
```

If you already have the package locally, make sure it lives at:

```
Server/Packages/Parley
```

## Step 2: Enable it in Config.toml

Open the server `Config.toml` (next to `NanosWorldServer.exe`) and add the package name under `packages`:

```toml
packages = [
  "Parley"
]
```

Note: on Linux, the package folder name is case-sensitive. If your folder is named `parley`, use `"parley"` in the list.

## Step 3: Start the server

```powershell
./NanosWorldServer.exe
```

Expected log lines (trimmed):

```text
INFO  Loading Package 'Parley'...
INFO  Package 'Parley' loaded.
```

## Step 4: Join the server

Launch nanos world and connect to:

```
127.0.0.1:7777
```

## Step 5: Trigger the demo dialogue

Parley registers a server console command called `parley`. In the server console, run:

```
parley
```

You should see the default WebUI open with a short dialogue. The content is loaded from `Examples/MinimalStart.lua`:

```lua
local asset = Parley.Load([[start:
Narrator: Welcome, {{player.name}}.
...
]], { is_string = true, cache = true })
```

Expected console output (server and client combined):

```text
[Parley] show_line -> remote
[Parley] client show_line
```

If the UI does not appear, jump to [Troubleshooting](troubleshooting.md).

## What you just ran (Hello Dialogue)

The simplest dialogue file looks like this:

```text
start:
Narrator: Welcome to Parley.
- Who are you? -> who
- Goodbye. -> end

who:
Narrator: Just a guide.
end
```

That exact example lives at `Examples/dialogues/Minimal.txt` and is a great starting point for your own scripts.

