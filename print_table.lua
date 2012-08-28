--[[
    print_table.lua
    Copyright 2010 Nicolas Goles. All Rights Reserved. 
    test = { hello = "string", hello2 = "not a string"}
    print("run pformat")
    pformat(test)
]]--

function pformat(o, name, indent)
    local buf1, buf2 = '', ''
    indent = indent or ''

    local function has__tostring(o)
        local mt = getmetatable(o)
        return (mt ~= nil and mt.__tostring ~= nil)
    end

    -- simple serialization of everything except tables
    local function serialize(o)
        local s = tostring(o)
        local t = type(o)

        if t == 'nil' or t == 'boolean' or t == 'number' or has__tostring(o) then
            return s
        elseif t == 'function' then
            local info = debug.getinfo(o, 'S')
            if info.what == 'C' then
                s = s..', C function'
            else
                s = s..', defined in ('..
                info.linedefined..'-'..info.lastlinedefined..
                ')'..info.source
            end
        end
        return string.format('%q', s)
    end

    -- recursion
    local function stepin(o, name, indent, cache, field)
        buf1 = buf1 .. indent .. field

        if has__tostring(o) or type(o) ~= 'table' then
            -- simple datum
            buf1 = buf1 .. ' = ' .. serialize(o) .. ';\n'
        elseif cache[o] then
            -- cached table
            buf1 = buf1 .. ' = {}; -- ' .. cache[o] .. ' (self reference)\n'
            buf2 = buf2 .. name .. ' = ' .. cache[o] .. ';\n'
        else
            -- new table
            cache[o] = name
            if next(o) == nil then -- empty table
                buf1 = buf1 .. ' = {};\n'
            else
                buf1 = buf1 .. ' = {\n'
                for k,v in pairs(o) do
                    k = string.format('[%s]', serialize(k))
                    stepin(v, name..k, indent..'   ', cache, k)
                end
                buf1 = buf1 .. indent .. '};\n'
            end
        end
    end

    if name == nil then
        if has__tostring(o) or type(o) ~= 'table' then
            return serialize(o)
        elseif next(o) == nil then
            return '{}'
        else
            local cache = {}
            cache[o] = '__unnamed__'
            buf1 = '{\n'
            for k,v in pairs(o) do
                k = string.format('[%s]', serialize(k))
                stepin(v, k, indent..'   ', cache, k)
            end
            buf1 = buf1 .. indent .. '}'
        end
    elseif has__tostring(o) or type(o) ~= 'table' then
        -- simple datum
        return tostring(name) .. ' = ' .. serialize(o) .. ';\n'
    else
        -- table, let's unwind
        stepin(o, name, indent or '', {}, name)
    end
    return buf1 .. buf2
end
