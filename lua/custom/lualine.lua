require("lualine").setup {
    winbar = {
        lualine_b = {
            { "filename", path = 4 },
            {
                "navic",
                color_correction = nil,
                navic_opts = nil,
            },
        },
    },
}
