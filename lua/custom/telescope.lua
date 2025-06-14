local data = assert(vim.fn.stdpath "data") --[[@as string]]

require("telescope").setup {
    extensions = {
        fzf = {},
        wrap_results = true,
        history = {
            path = data .. "telescope_history.sqlite3",
            limit = 100,
        },
    },
}

pcall(require("telescope").load_extension, "fzf")
pcall(require("telescope").load_extension, "smart_history")
pcall(require("telescope").load_extension, "dap")

local builtin = require "telescope.builtin"

vim.keymap.set("n", "<leader>f?", builtin.resume, { desc = "resume last telescope" })
vim.keymap.set(
    "n",
    "<leader>fa",
    function() builtin.find_files { hidden = true, no_ignore = true, follow = true } end,
    { desc = "[f]ind file amongs [a]ll files" }
)
vim.keymap.set(
    "n",
    "<leader>fb",
    function() require("telescope").extensions.dap.list_breakpoints { initial_mode = "normal" } end,
    { desc = "[F]ind [B]reakpoints" }
)
vim.keymap.set(
    "n",
    "<leader>fc",
    function() builtin.find_files { cwd = vim.fn.stdpath "config" } end,
    { desc = "[f]ind [c]onfig file" }
)
vim.keymap.set(
    "n",
    "<leader>fd",
    function() builtin.diagnostics { initial_mode = "normal" } end,
    { desc = "[f]ind [d]diagnostic in current buffer" }
)
vim.keymap.set("n", "<leader>fg", builtin.live_grep, { desc = "[f]ind using rip[g]rep" })
vim.keymap.set("n", "<leader>fh", builtin.help_tags, { desc = "[f]ind nvim [h]elp tag" })
vim.keymap.set(
    "n",
    "<leader>fp",
    function()
        builtin.find_files {
            find_command = { "rg", "--hidden", "-g", "!.git/*", "--files", "--color", "never" },
        }
    end,
    { desc = "[f]ind file in [p]roject" }
)
vim.keymap.set(
    "n",
    "<leader>fr",
    function() builtin.lsp_references { initial_mode = "normal" } end,
    { desc = "[f]ind [r]eferences to symbol" }
)
vim.keymap.set(
    "n",
    "<leader>fs",
    builtin.lsp_document_symbols,
    { desc = "[f]ind [s]ymbol in buffer" }
)
vim.keymap.set(
    "n",
    "<leader>ft",
    function() require("telescope").extensions["todo-comments"].todo { initial_mode = "normal" } end,
    { desc = "[f]ind [T]odo" }
)
vim.keymap.set(
    "n",
    "<leader>fw",
    function() builtin.live_grep { additional_args = { "-w" }, prompt_title = "Find word" } end,
    { desc = "[f]ind [w] using ripgrep" }
)
vim.keymap.set(
    "n",
    "<leader>/",
    builtin.current_buffer_fuzzy_find,
    { desc = "fuzzy search in buffer" }
)

vim.keymap.set("n", "<leader>gw", builtin.grep_string)

-- vim.keymap.set("n", "<leader>fa", function()
--     ---@diagnostic disable-next-line: param-type-mismatch
--     builtin.find_files { cwd = vim.fs.joinpath(vim.fn.stdpath "data", "lazy") }
-- end)

vim.api.nvim_create_autocmd("User", {
    pattern = "TelescopePreviewerLoaded",
    callback = function() vim.wo.wrap = true end,
})
