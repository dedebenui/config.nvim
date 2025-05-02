return {
    {
        "catppuccin/nvim",
        name = "catppuccin",
        priority = 1000,
        config = function()
            local flavor = "mocha"
            if vim.uv.os_environ()["DARK_MODE"] == "false" then flavor = "latte" end
            require("catppuccin").setup { flavour = flavor }
            vim.cmd.colorscheme "catppuccin"
        end,
    },
}
