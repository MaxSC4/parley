local Validate = {}

function Validate.type(value, expected, label)
    if type(value) ~= expected then
        error("Expected " .. label .. " to be " .. expected)
    end
end

return Validate
