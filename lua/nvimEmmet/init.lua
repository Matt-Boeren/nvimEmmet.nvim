local M = {}

local fn = require("nvimEmmet.functions")


local emmet = function (opts)
    local command = opts.args

    local strArray = fn.cmdToArray(command)

 --   vim.fn.setreg('r', strArray)
 --   vim.cmd('put! r')
    local resultArray = fn.getResultArray(strArray)
--    vim.fn.setreg('r', resultArray)
--    vim.cmd('put! r')
    local result = fn.getResult(resultArray)
    vim.fn.setreg('r', result)
    vim.cmd('put! r')
end

function M.setup()
    vim.api.nvim_create_user_command("Emmet",emmet, {
        nargs = 1,
        desc = "trigger",
    })
end

return M
