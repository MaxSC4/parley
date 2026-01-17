local Steps = require("parley/runtime/steps.lua")
local Expr = require("parley/util/expr.lua")
local Log = require("parley/util/log.lua")

local Engine = {}

local function resolve_path(provider, ctx, path)
    if provider and provider.get then
        return provider.get(ctx, path)
    end
    return nil
end

function Engine.DefaultResolveText(provider, ctx, template)
    local function repl(key)
        local val = resolve_path(provider, ctx, key)
        if val == nil then
            return ""
        end
        return tostring(val)
    end

    local result = template:gsub("{{%s*([%w_%.]+)%s*}}", repl)
    return result
end

local function eval_condition(provider, ctx, expr)
    if expr == nil or expr == "" then
        return true
    end
    if provider and provider.eval then
        return provider.eval(ctx, expr)
    end
    local function resolver(path)
        return resolve_path(provider, ctx, path)
    end
    return Expr.Eval(expr, resolver)
end

local function apply_action(provider, ctx, action)
    if provider and provider.apply then
        provider.apply(ctx, action)
    end
end

local function get_steps(session)
    local label = session.label
    local node = session.asset.labels[label]
    if not node then
        error("Parley missing label: " .. tostring(label))
    end
    return node.steps
end

local function next_step(session)
    local steps = get_steps(session)
    local step = steps[session.index]
    session.index = session.index + 1
    return step
end

function Engine.Choose(session, choice_id)
    local choices = session.waiting_choices
    session.waiting_choices = nil
    if not choices then
        return nil
    end
    local choice = choices[choice_id]
    if not choice then
        return nil
    end
    if choice.target and choice.target ~= "" then
        if choice.target == "end" then
            session._force_end = "end"
        else
            session.label = choice.target
            session.index = 1
        end
    end
    return choice
end

function Engine.Next(session, provider, resolver)
    local ctx = session.opts and session.opts.context or {}

    local function context_error(msg, step)
        local line = step and step._line or "?"
        local label = session.label or "?"
        local detail = ""
        if step then
            if step.action then
                detail = detail .. " action=" .. tostring(step.action)
            end
            if step.condition then
                detail = detail .. " condition=" .. tostring(step.condition)
            end
            if step.target then
                detail = detail .. " target=" .. tostring(step.target)
            end
        end
        local header = "Parley runtime error [session " .. tostring(session.id)
            .. " label " .. tostring(label) .. " line " .. tostring(line) .. "]:"
        error(header .. detail .. " " .. msg)
    end

    while true do
        if session._force_end then
            local reason = session._force_end
            session._force_end = nil
            return Steps.End(reason)
        end
        local step = next_step(session)
        if not step then
            return Steps.End("eof")
        end

        if step.type == "action" then
            local ok_cond, cond = pcall(eval_condition, provider, ctx, step.condition)
            if not ok_cond then
                context_error(cond, step)
            end
            if cond then
                local ok_act, act_err = pcall(apply_action, provider, ctx, step.action)
                if not ok_act then
                    context_error(act_err, step)
                end
            end
        elseif step.type == "jump" then
            local ok_cond, cond = pcall(eval_condition, provider, ctx, step.condition)
            if not ok_cond then
                context_error(cond, step)
            end
            if cond then
                if step.target == "end" then
                    return Steps.End("end")
                end
                session.label = step.target
                session.index = 1
            end
        elseif step.type == "line" then
            local ok_cond, cond = pcall(eval_condition, provider, ctx, step.condition)
            if not ok_cond then
                context_error(cond, step)
            end
            if cond then
                local ok_res, text_or_err = pcall(resolver, session.player, ctx, step.text)
                if not ok_res then
                    context_error(text_or_err, step)
                end
                return Steps.Line(step.speaker, text_or_err, { session_id = session.id })
            end
        elseif step.type == "choices" then
            local ok_cond, cond = pcall(eval_condition, provider, ctx, step.condition)
            if not ok_cond then
                context_error(cond, step)
            end
            if cond then
                local filtered = {}
                for _, choice in ipairs(step.choices) do
                    local ok_c, c = pcall(eval_condition, provider, ctx, choice.condition)
                    if not ok_c then
                        context_error(c, step)
                    end
                    if c then
                        table.insert(filtered, choice)
                    end
                end
                if #filtered > 0 then
                    local indexed = {}
                    for i, choice in ipairs(filtered) do
                        local ok_res, text_or_err = pcall(resolver, session.player, ctx, choice.text)
                        if not ok_res then
                            context_error(text_or_err, step)
                        end
                        indexed[i] = { id = i, text = text_or_err, target = choice.target }
                    end
                    session.waiting_choices = indexed
                    return Steps.Choices(indexed)
                end
            end
        elseif step.type == "end" then
            return Steps.End("end")
        else
            Log.Warn("Unknown step type: " .. tostring(step.type))
        end
    end
end

function Engine.DispatchStep(adapter, session, step)
    local player = session.player
    if step.type == "line" and adapter.show_line then
        adapter.show_line(player, step, session)
        if session.opts.on_line then
            session.opts.on_line(player, step)
        end
    elseif step.type == "choices" and adapter.show_choices then
        adapter.show_choices(player, step.choices, session)
        if session.opts.on_choices then
            session.opts.on_choices(player, step.choices)
        end
    elseif step.type == "end" then
        if adapter.hide then
            adapter.hide(player, session)
        end
        if session.opts.on_end then
            session.opts.on_end(player, step.reason)
        end
    end
end

return Engine




