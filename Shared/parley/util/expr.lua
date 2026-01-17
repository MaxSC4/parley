local Expr = {}

local function is_space(c)
    return c == " " or c == "\t" or c == "\r" or c == "\n"
end

local function is_digit(c)
    return c and c:match("%d") ~= nil
end

local function is_ident_start(c)
    return c and c:match("[A-Za-z_]") ~= nil
end

local function is_ident_part(c)
    return c and c:match("[A-Za-z0-9_\\.]") ~= nil
end

local function tokenize(input)
    local tokens = {}
    local i = 1
    local len = #input

    while i <= len do
        local c = input:sub(i, i)
        if is_space(c) then
            i = i + 1
        elseif c == "\"" or c == "'" then
            local quote = c
            local j = i + 1
            while j <= len and input:sub(j, j) ~= quote do
                j = j + 1
            end
            if j > len then
                error("Unterminated string in expression")
            end
            local str = input:sub(i + 1, j - 1)
            table.insert(tokens, { type = "string", value = str })
            i = j + 1
        elseif is_digit(c) then
            local j = i
            while j <= len and input:sub(j, j):match("[0-9\\.]") do
                j = j + 1
            end
            local num = tonumber(input:sub(i, j - 1))
            if num == nil then
                error("Invalid number in expression")
            end
            table.insert(tokens, { type = "number", value = num })
            i = j
        elseif is_ident_start(c) then
            local j = i
            while j <= len and is_ident_part(input:sub(j, j)) do
                j = j + 1
            end
            local word = input:sub(i, j - 1)
            if word == "and" or word == "or" or word == "not" or word == "true" or word == "false" then
                table.insert(tokens, { type = "keyword", value = word })
            else
                table.insert(tokens, { type = "ident", value = word })
            end
            i = j
        else
            local two = input:sub(i, i + 1)
            if two == "==" or two == "!=" or two == ">=" or two == "<=" then
                table.insert(tokens, { type = "op", value = two })
                i = i + 2
            elseif c == ">" or c == "<" or c == "(" or c == ")" then
                table.insert(tokens, { type = "op", value = c })
                i = i + 1
            else
                error("Invalid token in expression: " .. c)
            end
        end
    end

    return tokens
end

local function parse(tokens, resolver)
    local pos = 1

    local function peek()
        return tokens[pos]
    end

    local function next_tok()
        local t = tokens[pos]
        pos = pos + 1
        return t
    end

    local function parse_expr(min_bp)
        local tok = next_tok()
        if not tok then
            error("Unexpected end of expression")
        end

        local left
        if tok.type == "number" or tok.type == "string" then
            left = tok.value
        elseif tok.type == "keyword" and (tok.value == "true" or tok.value == "false") then
            left = (tok.value == "true")
        elseif tok.type == "ident" then
            left = resolver(tok.value)
        elseif tok.type == "keyword" and tok.value == "not" then
            local rhs = parse_expr(70)
            left = not rhs
        elseif tok.type == "op" and tok.value == "(" then
            left = parse_expr(0)
            local close = next_tok()
            if not close or close.value ~= ")" then
                error("Expected ')' in expression")
            end
        else
            error("Unexpected token in expression")
        end

        while true do
            local op = peek()
            if not op then
                break
            end

            local lbp, rbp
            if op.type == "keyword" and op.value == "or" then
                lbp, rbp = 10, 11
            elseif op.type == "keyword" and op.value == "and" then
                lbp, rbp = 20, 21
            elseif op.type == "op" and (op.value == "==" or op.value == "!=" or op.value == ">"
                or op.value == "<" or op.value == ">=" or op.value == "<=") then
                lbp, rbp = 30, 31
            else
                break
            end

            if lbp < min_bp then
                break
            end

            next_tok()
            local right = parse_expr(rbp)

            if op.type == "keyword" and op.value == "or" then
                left = left or right
            elseif op.type == "keyword" and op.value == "and" then
                left = left and right
            elseif op.type == "op" and op.value == "==" then
                left = left == right
            elseif op.type == "op" and op.value == "!=" then
                left = left ~= right
            elseif op.type == "op" and op.value == ">" then
                left = left > right
            elseif op.type == "op" and op.value == "<" then
                left = left < right
            elseif op.type == "op" and op.value == ">=" then
                left = left >= right
            elseif op.type == "op" and op.value == "<=" then
                left = left <= right
            end
        end

        return left
    end

    return parse_expr(0)
end

function Expr.Eval(expr, resolver)
    local tokens = tokenize(expr)
    return parse(tokens, resolver)
end

return Expr
