local dark_mode = function()
    require("catppuccin").setup { flavour = "mocha" }
    vim.cmd.colorscheme "catppuccin"
end

local light_mode = function()
    require("catppuccin").setup { flavour = "latte" }
    vim.cmd.colorscheme "catppuccin"
end

vim.api.nvim_create_user_command("Darkmode", dark_mode, {})
vim.api.nvim_create_user_command("Lightmode", light_mode, {})
