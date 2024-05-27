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
    commands = {
        system_open = function(state)
            local node = state.tree:get_node()
            local path = node:get_id()
            if path == nil then return end
            vim.print(path)
            vim.fn.jobstart({ "/usr/bin/open", path }, { detach = true })
        end,
    },
    filesystem = {
        hide_gitignored = false,
        never_show = {
            ".DS_Store",
        },
        window = {
            mappings = {
                ["s"] = "system_open",
            },
        },
    },
}

vim.fn.sign_define("DiagnosticSignError", { text = " ", texthl = "DiagnosticSignError" })
vim.fn.sign_define("DiagnosticSignWarn", { text = " ", texthl = "DiagnosticSignWarn" })
vim.fn.sign_define("DiagnosticSignInfo", { text = " ", texthl = "DiagnosticSignInfo" })
vim.fn.sign_define("DiagnosticSignHint", { text = "󰌵", texthl = "DiagnosticSignHint" })

vim.keymap.set("n", "<leader>e", "<CMD>Neotree reveal toggle float<CR>", { desc = "NeoTree" })
