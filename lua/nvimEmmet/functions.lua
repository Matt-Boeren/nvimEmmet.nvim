local attr = require('lua.nvimEmmet.attributes')

--helper functions

---@param trigger string
---@param indent integer
local tagTrigger = function(trigger, indent)
    local tag = ''
    local attributes = {}
    local attributeString = ''
    local lastIndex = 1
    local ind = ""
    if indent ~= 0 then
        ind = string.rep("\t", indent)
    end
    for i = 1, #trigger do
        local c = trigger:sub(i,i)
        if string.match("#:.", c) then
            table.insert(attributes, trigger:sub(lastIndex, i-1))
            table.insert(attributes, c)
            lastIndex = i+1
        elseif i == #trigger then
            table.insert(attributes, trigger:sub(lastIndex, i))
        end
    end

    for i = 2, #attributes, 2 do
        local res = attr[attributes[i]]
        attributeString = attributeString .. ' ' .. res .. attributes[i+1] .. '"'
    end

    tag = ind ..'<' .. attributes[1] .. attributeString ..'>\n'.. ind ..'\t\n' .. ind .. '</' .. attributes[1] .. '>'

    return tag
end


---@param str string
---@param pat string
---@param rep string
local strReplace = function (str, pat, rep)
    local index = #str
    while index > #pat do
        local part = str:sub(index-#pat, index - 1)
        if part == pat then
            str = string.sub(str, 1, index-#pat - 1) .. rep .. string.sub(str, index, #str)
            index = 0
        end
        index = index -1
    end
    return str
end

--functions needed in init.lua
return{

    ---@param command string
    cmdToArray = function (command)
        local strArray = {}
        local lastIndex = 1
        local separators = { [">"] = true, ["+"] = true, ["*"] = true }
        for i = 1, #command do
            local c = command:sub(i,i)
            if separators[c] then
                table.insert(strArray, command:sub(lastIndex, i-1))
                table.insert(strArray, c)
                lastIndex = i+1
            elseif i == #command then --if last character
                table.insert(strArray, command:sub(lastIndex, i))
            end

        end
        return strArray
    end,


    ---@param strArray table
    getResultArray = function(strArray)

        local resultArray = {}
        local i = 1

        local indent = 0
        while i <= #strArray do
            if tonumber(strArray[i]) and strArray[i+1] == "*" then
                local number = tonumber(strArray[i])
                local tag = ""
                if i > 1 and strArray[i-1] == ">" then
                    indent = indent + 1
                end
                tag = tagTrigger(strArray[i+2], indent)

                local res = tag
                for j = 2, number, 1 do
                    res = res .. "\n" .. tag
                end
                table.insert(resultArray, res)
                i = i + 3
            elseif string.match(">+", strArray[i]) then
                table.insert(resultArray, strArray[i])
                if string.match("+", strArray[i]) then
                    indent = 0
                end
                i = i + 1
            else

                if i > 1 and strArray[i-1] == ">" then
                    indent = indent + 1
                end
                table.insert(resultArray, tagTrigger(strArray[i], indent))
                i = i + 1
            end
        end
        return resultArray
    end,

    ---@param resultArray table
    getResult = function(resultArray)

        local result = ""
        local j = 1
        local indent = 1
        while j <= #resultArray do
            if resultArray[j] == ">" then
                local tabs = string.rep("\t", indent)
                result = strReplace(result, tabs, resultArray[j+1])
                indent = indent + 1
                j = j + 2
            elseif resultArray[j] == "+" then
                result = result .. "\n" ..resultArray[j+1]
                j = j + 2
            else
                result = result .. resultArray[j]
                j = j + 1
            end
        end
        return result
    end
}
