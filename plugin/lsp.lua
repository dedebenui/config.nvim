vim.lsp.enable {
    "basedpyright",
    "css-ls",
    "json-ls",
    "ltex",
    "lua_ls",
    "nu",
    "ols",
    "ruff",
    "rust-analyzer",
    "taplo",
    "tinymist",
}

vim.api.nvim_create_autocmd("LspAttach", {
    callback = function(args)
        assert(vim.lsp.get_client_by_id(args.data.client_id), "must have valid client")
        vim.opt_local.omnifunc = "v:lua.vim.lsp.omnifunc"
    end,
})
