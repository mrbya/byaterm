local M = {}

function M.gen_window()
    local width = math.floor(vim.o.columns * 0.8)
    local height = math.floor(vim.o.lines * 0.8)
    local col = math.floor((vim.o.columns - width) / 2)
    local row = math.floor((vim.o.lines - height) / 2)

    local buf = vim.api.nvim_create_buf(false, true)

    local win = vim.api.nvim_open_win(
        buf,
        true,
        {
            relative = 'editor',
            width = width,
            height = height,
            col = col,
            row = row,
            style = 'minimal'
        }
    )

    vim.fn.termopen(vim.o.shell)

    vim.api.nvim_set_current_win(win)
    vim.cmd('startinsert')

    vim.api.nvim_create_autocmd(
        'TermClose',
        {
            buffer = buf,
            callback = function()
                vim.api.nvim_win_close(win, true)
            end
        }
    )
end

function M.setup()
    vim.api.nvim_create_user_command(
        'ByatermNew',
        ':lua require("byaterm").gen_window() <CR>',
        {}
    )
end

return M
