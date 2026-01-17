local Steps = {}

function Steps.Line(speaker, text, meta)
    return { type = "line", speaker = speaker, text = text, meta = meta or {} }
end

function Steps.Choices(choices)
    return { type = "choices", choices = choices }
end

function Steps.End(reason)
    return { type = "end", reason = reason or "end" }
end

return Steps
