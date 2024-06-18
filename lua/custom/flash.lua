local flash = require "flash"

flash.setup {}

vim.keymap.set({ "n", "x", "o" }, "s", function() flash.jump() end, { desc = "Flash" })
vim.keymap.set(
    { "n", "x", "o" },
    "S",
    function() flash.treesitter_search() end,
    { desc = "Treesitter search" }
)
vim.keymap.set(
    { "n", "x", "o" },
    "<leader>;",
    function()
        flash.treesitter {
            label = { before = false, after = false },
            jump = {
                pos = "start",
            },
        }
    end,
    { desc = "Jump up TS nodes" }
)
