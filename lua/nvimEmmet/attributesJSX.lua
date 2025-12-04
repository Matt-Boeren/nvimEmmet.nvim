
return {

    getAttributes = function ()
        return {
            ["#"] = 'id="',
            ["?"] = 'className="',
            [":"] = 'type="'
        }
    end,
    getMatchString = function ()
        return "#?:"
    end
}
