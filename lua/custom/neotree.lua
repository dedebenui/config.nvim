require("neo-tree").setup {
    close_if_last_window = true,
    enable_git_status = true,
    enable_diagnostics = true,
    open_files_do_not_replace_types = { "terminal", "trouble", "qf" },
    sort_case_insensitive = true,
    update_cwd = true,
    update_focused_file = {
        enable = true,
        update_cwd = true,
    },
    buffers = {
        follow_current_file = {
            enabled = true,
            leave_dirs_open = false,
        },
    },
    filesystem = {
        hide_gitignored = false,
        never_show = {
            ".DS_Store",
        },
    },
}

vim.fn.sign_define("DiagnosticSignError", { text = " ", texthl = "DiagnosticSignError" })
vim.fn.sign_define("DiagnosticSignWarn", { text = " ", texthl = "DiagnosticSignWarn" })
vim.fn.sign_define("DiagnosticSignInfo", { text = " ", texthl = "DiagnosticSignInfo" })
vim.fn.sign_define("DiagnosticSignHint", { text = "󰌵", texthl = "DiagnosticSignHint" })

vim.keymap.set("n", "<leader>e", "<CMD>Neotree reveal toggle<CR>", { desc = "NeoTree" })
