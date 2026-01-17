local Tokenizer = require("parley/parser/tokenizer.lua")
local Errors = require("parley/parser/errors.lua")

local Parser = {}

local function trim(s)
    return (s:gsub("^%s+", ""):gsub("%s+$", ""))
end

local function is_comment(line)
    return line:match("^%s*#") or line:match("^%s*//")
end

local function parse_choice(text)
    local choice_text = text
    local target_label = nil
    local before, label = text:match("^(.-)%s*%-%>%s*(%S+)%s*$")
    if before then
        choice_text = trim(before)
        target_label = label
    end
    return choice_text, target_label
end

local function parse_line(text)
    if text:match("^goto%s+") then
        local label = text:match("^goto%s+([%w_%-]+)")
        return { type = "jump", target = label }
    end
    if text == "end" then
        return { type = "end" }
    end
    if text:match("^do%s+") then
        local action = text:match("^do%s+(.+)$")
        return { type = "action", action = action }
    end
    if text:match("^set%s+") then
        local action = text:match("^set%s+(.+)$")
        return { type = "action", action = action }
    end
    local speaker, line_text = text:match("^([^:]+):%s*(.+)$")
    if speaker then
        return { type = "line", speaker = trim(speaker), text = line_text }
    end
    if text:match("^[-*]%s+") then
        local choice_body = text:match("^[-*]%s+(.+)$")
        local choice_text, target_label = parse_choice(choice_body)
        return { type = "choice", text = choice_text, target = target_label }
    end
    return nil
end

function Parser.Parse(text, opts)
    opts = opts or {}
    local lines = Tokenizer.Lines(text)
    local asset = {
        id = opts.id,
        file = opts.file,
        labels = {},
        order = {}
    }

    local current_label = nil
    local function ensure_label(label)
        if not asset.labels[label] then
            asset.labels[label] = { steps = {} }
            table.insert(asset.order, label)
        end
    end

    local function push_step(step, line_num, raw)
        if not current_label then
            current_label = "start"
            ensure_label(current_label)
        end
        step._line = line_num
        step._raw = raw
        table.insert(asset.labels[current_label].steps, step)
    end

    for _, entry in ipairs(lines) do
        local raw = entry.text
        local line = trim(raw)
        if line ~= "" and not is_comment(line) then
            local label = line:match("^([%w_%-]+):$")
            if label then
                current_label = label
                ensure_label(label)
            else
                local cond_kind, cond_expr, rest = line:match("^(if)%s+([^:]+):%s*(.+)$")
                if not cond_kind then
                    cond_kind, cond_expr, rest = line:match("^(when)%s+([^:]+):%s*(.+)$")
                end

                local condition = nil
                if cond_kind then
                    condition = trim(cond_expr)
                    line = trim(rest)
                end

                local step = parse_line(line)
                if not step then
                    local err = Errors.New("Unrecognized line", opts.file, entry.num, raw)
                    error(Errors.Format(err))
                end

                if step.type == "choice" then
                    if not current_label then
                        current_label = "start"
                        ensure_label(current_label)
                    end
                    local last_steps = asset.labels[current_label]
                    local last = last_steps and last_steps.steps[#last_steps.steps]
                    if last and last.type == "choices" then
                        step.condition = condition
                        table.insert(last.choices, step)
                    else
                        local choices_step = { type = "choices", choices = {} }
                        step.condition = condition
                        table.insert(choices_step.choices, step)
                        push_step(choices_step, entry.num, raw)
                    end
                else
                    step.condition = condition
                    push_step(step, entry.num, raw)
                end
            end
        end
    end

    if not next(asset.labels) then
        local err = Errors.New("Dialogue contains no content", opts.file, 1, "")
        error(Errors.Format(err))
    end

    return asset
end

return Parser





