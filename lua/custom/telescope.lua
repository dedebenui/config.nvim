local data = assert(vim.fn.stdpath "data") --[[@as string]]
print(data)

require("telescope").setup {
    defaults = {
        file_ignore_patterns = {
            "Cargo.lock",
        },
    },
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

local builtin = require "telescope.builtin"

vim.keymap.set(
    "n",
    "<leader>fc",
    function() builtin.find_files { cwd = vim.fn.stdpath "config" } end,
    { desc = "[f]ind [c]onfig file" }
)
vim.keymap.set(
    "n",
    "<leader>fd",
    function() builtin.diagnostics { bufnr = 0 } end,
    { desc = "[f]ind [d]diagnostic in current buffer" }
)
vim.keymap.set("n", "<leader>fp", builtin.find_files, { desc = "[f]ind file in [p]roject" })
vim.keymap.set(
    "n",
    "<leader>fs",
    builtin.lsp_document_symbols,
    { desc = "[f]ind [s]ymbol in buffer" }
)
vim.keymap.set("n", "<leader>fg", builtin.live_grep, { desc = "[f]ind using rip[g]rep" })
vim.keymap.set("n", "<leader>fh", builtin.help_tags, { desc = "[f]ind nvim [h]elp tag" })
vim.keymap.set(
    "n",
    "<leader>fr",
    builtin.lsp_references,
    { desc = "[f]ind [r]eferences to symbol" }
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
