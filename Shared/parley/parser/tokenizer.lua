local Tokenizer = {}

function Tokenizer.Lines(text)
    local lines = {}
    local line_num = 1
    for line in (text .. "\n"):gmatch("(.-)\n") do
        table.insert(lines, { num = line_num, text = line })
        line_num = line_num + 1
    end
    return lines
end

return Tokenizer
