# Installation

## Prerequisites

- nanos world server (this package targets compatibility version `1.69` per `Package.toml`).
- A script-type package environment (Server/Client/Shared folders).

## Folder structure

Parley is a scripting package with the standard nanos world layout:

```
Parley/
|- Server/
|  `- Index.lua
|- Client/
|  |- Index.lua
|  `- ui/parleyui/...
|- Shared/
|  |- Index.lua
|  `- parley/...
`- Package.toml
```

The server loads `Server/Index.lua`, the client loads `Client/Index.lua`, and shared code lives in `Shared/`.

## Enable the package

Add the package name to your server `Config.toml`:

```toml
packages = [
  "Parley"
]
```

When the server starts, it will load Parley and register a `parley` console command for the demo.

## Optional dependencies

There are no required asset or package dependencies listed in `Package.toml`.
