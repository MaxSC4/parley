local Parser = require("parley/parser/parser.lua")
local Engine = require("parley/runtime/engine.lua")
local Session = require("parley/runtime/session.lua")
local Log = require("parley/util/log.lua")
local Validate = require("parley/util/validate.lua")

local Parley = {}

local _asset_cache = {}
local _sessions_by_id = {}
local _sessions_by_player = {}
local _next_session_id = 1

local _state_provider_fn = nil
local _text_resolver_fn = nil
local _ui_adapter = nil

local function get_player_key(player)
    if player == nil then
        return "local"
    end
    if type(player) == "table" and player.GetID then
        return tostring(player:GetID())
    end
    return tostring(player)
end

local function get_provider(player)
    if _state_provider_fn then
        return _state_provider_fn(player)
    end
    return nil
end

local function resolve_text(player, ctx, template)
    if _text_resolver_fn then
        return _text_resolver_fn(player, ctx, template)
    end
    local provider = get_provider(player)
    return Engine.DefaultResolveText(provider, ctx, template)
end

local function set_session(player, session)
    local key = get_player_key(player)
    _sessions_by_player[key] = session
    _sessions_by_id[session.id] = session
end

local function clear_session(player, session)
    if session then
        _sessions_by_id[session.id] = nil
    end
    local key = get_player_key(player)
    if _sessions_by_player[key] and _sessions_by_player[key].id == session.id then
        _sessions_by_player[key] = nil
    end
end

local function dispatch_step(session, step)
    Engine.DispatchStep(_ui_adapter, session, step)
    if step.type == "end" then
        clear_session(session.player, session)
    end
end

function Parley.RegisterStateProvider(fn)
    Validate.type(fn, "function", "state provider")
    _state_provider_fn = fn
end

function Parley.SetTextResolver(fn)
    Validate.type(fn, "function", "text resolver")
    _text_resolver_fn = fn
end

function Parley.SetUIAdapter(adapter)
    Validate.type(adapter, "table", "ui adapter")
    _ui_adapter = adapter
end

function Parley.Load(path_or_string, opts)
    opts = opts or {}
    local text
    if type(path_or_string) ~= "string" then
        error("Parley.Load expects a string")
    end

    if opts.is_string or path_or_string:find("\n") then
        text = path_or_string
    else
        local f = io.open(path_or_string, "r")
        if not f then
            error("Parley.Load failed to open: " .. path_or_string)
        end
        text = f:read("*a")
        f:close()
    end

    local asset = Parser.Parse(text, { file = opts.file or path_or_string, id = opts.id })
    if opts.id then
        _asset_cache[opts.id] = asset
    end
    if opts.cache then
        _asset_cache[path_or_string] = asset
    end
    return asset
end

function Parley.Start(player, asset_or_id, opts)
    opts = opts or {}
    if _ui_adapter == nil then
        error("Parley UI adapter not set; call Parley.SetUIAdapter")
    end

    local asset = nil
    if type(asset_or_id) == "table" then
        asset = asset_or_id
    elseif type(asset_or_id) == "string" then
        asset = _asset_cache[asset_or_id]
        if not asset then
            error("Parley.Start unknown asset id: " .. asset_or_id)
        end
    else
        error("Parley.Start expects asset or asset id")
    end

    if Parley.IsRunning(player) then
        Parley.Stop(player, nil, "restart")
    end

    local session_id = _next_session_id
    _next_session_id = _next_session_id + 1
    local session = Session.New(session_id, player, asset, opts)
    set_session(player, session)

    local provider = get_provider(player)
    local ok, step_or_err = pcall(Engine.Next, session, provider, resolve_text)
    if ok then
        if step_or_err then
            dispatch_step(session, step_or_err)
        end
    else
        if session.opts.on_error then
            session.opts.on_error(player, step_or_err)
        else
            error(step_or_err)
        end
    end

    return session_id
end

function Parley.Continue(player, session_id)
    local session = _sessions_by_id[session_id]
    if not session then
        return
    end
    local provider = get_provider(player)
    local ok, step_or_err = pcall(Engine.Next, session, provider, resolve_text)
    if ok then
        if step_or_err then
            dispatch_step(session, step_or_err)
        end
    else
        if session.opts.on_error then
            session.opts.on_error(player, step_or_err)
        else
            error(step_or_err)
        end
    end
end

function Parley.SelectChoice(player, session_id, choice_id)
    local session = _sessions_by_id[session_id]
    if not session then
        return
    end
    local selected = Engine.Choose(session, choice_id)
    if selected and session.opts.on_choice_selected then
        session.opts.on_choice_selected(player, selected)
    end
    local provider = get_provider(player)
    local ok, step_or_err = pcall(Engine.Next, session, provider, resolve_text)
    if ok then
        if step_or_err then
            dispatch_step(session, step_or_err)
        end
    else
        if session.opts.on_error then
            session.opts.on_error(player, step_or_err)
        else
            error(step_or_err)
        end
    end
end

function Parley.Stop(player, session_id, reason)
    local session
    if session_id then
        session = _sessions_by_id[session_id]
    else
        local key = get_player_key(player)
        session = _sessions_by_player[key]
    end
    if not session then
        return
    end
    clear_session(player, session)
    if _ui_adapter and _ui_adapter.hide then
        _ui_adapter.hide(player, session)
    end
    if session.opts and session.opts.on_end then
        session.opts.on_end(player, reason or "stopped")
    end
end

function Parley.IsRunning(player)
    local key = get_player_key(player)
    return _sessions_by_player[key] ~= nil
end

function Parley.GetSession(session_id)
    return _sessions_by_id[session_id]
end

function Parley.GetAsset(asset_id)
    return _asset_cache[asset_id]
end

Parley._Log = Log

return Parley




