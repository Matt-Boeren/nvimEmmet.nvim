local M = {}

local fn = require("nvimEmmet.functions")


local emmet = function (opts)
    local command = opts.args

    local strArray = fn.cmdToArray(command)

--    vim.fn.setreg('r', strArray)
--    vim.cmd('put! r')
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

function M.callFromLine()

    local pos = vim.api.nvim_win_get_cursor(0)
    local row = pos[1]
    local buf = vim.api.nvim_get_current_buf()

    local command = vim.api.nvim_get_current_line()
    command = command:match("^%s*(.-)%s*$")
    vim.api.nvim_buf_set_lines(buf, row, row, false, {""})
    vim.api.nvim_buf_set_lines(buf, row - 1, row, false, {})
    emmet({ args = command})
end

return M
