require("conform").setup {
    -- formatters = {
    --     bibtool = {
    --         command = "bibtool",
    --         args = { "-s" },
    --     },
    -- },
    formatters_by_ft = {
        lua = { "stylua" },
        tex = { "latexindent" },
    },
}

vim.api.nvim_create_autocmd("BufWritePre", {
    callback = function(args)
        require("conform").format {
            bufnr = args.buf,
            lsp_fallback = true,
            quiet = true,
        }
    end,
})
