local DeepCopy = {}

function DeepCopy.Copy(t, seen)
    if type(t) ~= "table" then
        return t
    end
    if seen and seen[t] then
        return seen[t]
    end
    local copy = {}
    seen = seen or {}
    seen[t] = copy
    for k, v in pairs(t) do
        copy[DeepCopy.Copy(k, seen)] = DeepCopy.Copy(v, seen)
    end
    return copy
end

return DeepCopy
