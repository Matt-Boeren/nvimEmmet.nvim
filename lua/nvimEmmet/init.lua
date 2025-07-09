local M = {}

local tagTrigger = function(opts)
    local tag = "<" .. opts.args .. ">\n\n</" ..opts.args.. ">"
    vim.fn.setreg('r', tag)
    vim.cmd('put! r')
end

function M.setup()
    vim.api.nvim_create_user_command("Emmet",tagTrigger, {
        nargs = 1,
        desc = "trigger",
    })
end

return M
