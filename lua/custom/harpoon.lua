local harpoon = require "harpoon"

-- REQUIRED
harpoon:setup { settings = { save_on_toggle = true } }
-- REQUIRED

vim.keymap.set("n", "<leader>ha", function() harpoon:list():add() end)
vim.keymap.set("n", "<leader>he", function() harpoon.ui:toggle_quick_menu(harpoon:list()) end)

vim.keymap.set("n", "<space>1", function()
    harpoon:list():select(1)
    vim.cmd "e"
end)
vim.keymap.set("n", "<space>2", function()
    harpoon:list():select(2)
    vim.cmd "e"
end)
vim.keymap.set("n", "<space>3", function()
    harpoon:list():select(3)
    vim.cmd "e"
end)
vim.keymap.set("n", "<space>4", function()
    harpoon:list():select(4)
    vim.cmd "e"
end)
vim.keymap.set("n", "<space>5", function()
    harpoon:list():select(5)
    vim.cmd "e"
end)
vim.keymap.set("n", "<space>6", function()
    harpoon:list():select(6)
    vim.cmd "e"
end)
vim.keymap.set("n", "<space>7", function()
    harpoon:list():select(7)
    vim.cmd "e"
end)
vim.keymap.set("n", "<space>8", function()
    harpoon:list():select(8)
    vim.cmd "e"
end)
vim.keymap.set("n", "<space>9", function()
    harpoon:list():select(9)
    vim.cmd "e"
end)

vim.keymap.set("n", "<leader>hr", function()
    harpoon:list():select(1)
    vim.cmd "e"
    vim.cmd "vs"
    harpoon:list():select(2)
    vim.cmd "e"
end, { desc = "recall Harpoon 1 and 2" })
