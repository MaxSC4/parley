local Errors = {}

function Errors.New(message, file, line, snippet)
    return {
        message = message,
        file = file,
        line = line,
        snippet = snippet
    }
end

function Errors.Format(err)
    local parts = {}
    table.insert(parts, err.message)
    if err.file then
        table.insert(parts, "File: " .. err.file)
    end
    if err.line then
        table.insert(parts, "Line: " .. tostring(err.line))
    end
    if err.snippet then
        table.insert(parts, "Snippet: " .. err.snippet)
    end
    return table.concat(parts, " | ")
end

return Errors
