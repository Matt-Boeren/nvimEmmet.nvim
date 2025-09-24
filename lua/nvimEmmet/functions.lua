--helper functions
local specials = require('nvimEmmet.specials')

local getAttribute = function ()
    local fileExtention = vim.fn.expand('%:e')

    if fileExtention == 'jsx' or fileExtention == 'tsx' then
        return require('nvimEmmet.attributesJSX')
    else
        return require('nvimEmmet.attributes')
    end
end

---@param trigger string
---@param indent integer
local tagTrigger = function(trigger, indent)
    local tag = ''
    local attr = getAttribute()
    local ind = ""
    if indent ~= 0 then
        ind = string.rep("\t", indent)
    end

    local txt = ''
    local open = trigger:find("{")
    local close = trigger:find("}")
    if open and close then
        if close > open then
            txt = trigger:sub(open+1, close-1)
            local tempTrigger = trigger:sub(1, open-1) .. trigger:sub(close+1, #trigger)
            trigger = tempTrigger
        end
    end

    local lastIndex = 1
    local attributes = {}
    local attributeString = ''

    open = trigger:find("%[")
    close = trigger:find("%]")
    if open and close then
        if close > open then
            attributeString = ' ' .. trigger:sub(open+1, close-1)
            local tempTrigger = trigger:sub(1, open-1) .. trigger:sub(close+1, #trigger)
            trigger = tempTrigger
        end
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
    local special = specials[attributes[1]]
    if special then
        tag = ind
        for i = 1, #special, 1 do
            if i == 3 then
                tag = tag .. '\n'.. ind .. '\t' .. txt .. '\n' .. ind
            end
            tag = tag .. special[i]
            if i == 1 then
                tag = tag .. attributeString
            end
        end
    else
        tag = ind ..'<' .. attributes[1] .. attributeString ..'>\n'.. ind .. '\t' .. txt .. '\n' .. ind .. '</' .. attributes[1] .. '>'
    end

    return tag
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
            if strArray[i] == "*" then
                local number
                local trigger
                if tonumber(strArray[i-1]) then
                    number = tonumber(strArray[i-1])
                    trigger = strArray[i+1]
                elseif tonumber(strArray[i+1]) then
                    number = tonumber(strArray[i+1])
                    trigger = strArray[i-1]
                end
                local tag = ""
                if i > 2 and strArray[i-2] == ">" then
                    indent = indent + 1
                end

                local res = ""
                for j = 1, number, 1 do
                    local useTrigger = trigger
                    if string.match(trigger, "%$") then
                        useTrigger = string.gsub(trigger, '%$', j)
                    end
                    tag = tagTrigger(useTrigger, indent)
                    if j == 1 then
                        res = tag
                    else
                        res = res .. "\n" .. tag
                    end
                end
                table.insert(resultArray, res)
                i = i + 2

            elseif string.match(">+", strArray[i]) then
                table.insert(resultArray, strArray[i])
                if string.match("+", strArray[i]) then
                    indent = 0
                end
                i = i + 1

            elseif tonumber(strArray[i]) == nil and strArray[i+1] ~= "*" then

                if i > 1 and strArray[i-1] == ">" then
                    indent = indent + 1
                end
                table.insert(resultArray, tagTrigger(strArray[i], indent))
                i = i + 1
            else
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
                result = string.gsub(result, tabs, resultArray[j+1])
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
