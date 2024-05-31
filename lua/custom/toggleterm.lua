require("toggleterm").setup {
    open_mapping = [[<C-t>]],
    direction = "float",
    float_opts = {
        border = "curved",
    },
}

-- local bufs = vim.iter(vim.api.nvim_list_bufs())
--     :filter(function(nr) vim.print(vim.api.nvim_buf_get_name(nr)) end)
