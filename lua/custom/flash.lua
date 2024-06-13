local flash = require "flash"

flash.setup { mode = { char = { enabled = false } } }

vim.keymap.set({ "n", "x", "o" }, "s", function() flash.jump() end, { desc = "Flash" })
vim.keymap.set(
    { "n", "x", "o" },
    "S",
    function() flash.treesitter_search() end,
    { desc = "Treesitter search" }
)
