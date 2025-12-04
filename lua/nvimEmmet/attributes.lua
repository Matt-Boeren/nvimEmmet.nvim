
return {
    getAttributes = function ()
        return {
            ["#"] = 'id="',
            ["."] = 'class="',
            [":"] = 'type="'
        }
    end,
    getMatchString = function ()
        return "#.:"
    end
}
