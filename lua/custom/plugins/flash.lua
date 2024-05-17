return {
    {
        "folke/flash.nvim",
        event = "VeryLazy",
        config = function()
            require "custom.flash"
        end,
    }
}
