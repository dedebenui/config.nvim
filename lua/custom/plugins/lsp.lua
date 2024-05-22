return {
    {
        "neovim/nvim-lspconfig",
        dependencies = {
            "folke/neodev.nvim",
            "williamboman/mason.nvim",
            "williamboman/mason-lspconfig.nvim",
            "SmiteshP/nvim-navic",
            "WhoIsSethDaniel/mason-tool-installer.nvim",

            { "j-hui/fidget.nvim", opts = {} },

            -- Autoformatting
            "stevearc/conform.nvim",
        },
        config = function()
            require("neodev").setup {
                -- library = {
                --   plugins = { "nvim-dap-ui" },
                --   types = true,
                -- },
            }

            local capabilities = nil
            if pcall(require, "cmp_nvim_lsp") then
                capabilities = require("cmp_nvim_lsp").default_capabilities()
            end

            local lspconfig = require "lspconfig"

            local servers = {
                bashls = true,
                lua_ls = true,
                rust_analyzer = true,
                cssls = true,
                pyright = { settings = { python = { analysis = { typeCheckingMode = "off" } } } },
                ruff_lsp = {
                    on_attach = function(client, _)
                        if client.name == "ruff_lsp" then
                            -- Disable hover in favor of Pyright
                            client.server_capabilities.hoverProvider = false
                        end
                    end,
                },
                taplo = {
                    settings = {
                        evenBetterToml = {
                            schema = {
                                catalogs = { "https://taplo.tamasfe.dev/schema_index.json" },
                            },
                        },
                    },
                },

                clangd = {
                    -- TODO: Could include cmd, but not sure those were all relevant flags.
                    --    looks like something i would have added while i was floundering
                    init_options = { clangdFileStatus = true },
                    filetypes = { "c" },
                },
            }

            local servers_to_install = vim.tbl_filter(function(key)
                local t = servers[key]
                if type(t) == "table" then
                    return not t.manual_install
                else
                    return t
                end
            end, vim.tbl_keys(servers))

            require("mason").setup()
            local ensure_installed = {
                "stylua",
                "lua_ls",
            }

            vim.list_extend(ensure_installed, servers_to_install)
            require("mason-tool-installer").setup { ensure_installed = ensure_installed }

            for name, config in pairs(servers) do
                if config == true then config = {} end
                config = vim.tbl_deep_extend("force", {}, {
                    capabilities = capabilities,
                }, config)

                lspconfig[name].setup(config)
            end

            local disable_semantic_tokens = {
                lua = true,
            }

            vim.api.nvim_create_autocmd("LspAttach", {
                callback = function(args)
                    local bufnr = args.buf
                    local client = assert(
                        vim.lsp.get_client_by_id(args.data.client_id),
                        "must have valid client"
                    )
                    if client.server_capabilities.documentSymbolProvider then
                        require("nvim-navic").attach(client, bufnr)
                    end

                    vim.opt_local.omnifunc = "v:lua.vim.lsp.omnifunc"
                    local filetype = vim.bo[bufnr].filetype
                    if disable_semantic_tokens[filetype] then
                        client.server_capabilities.semanticTokensProvider = nil
                    end
                end,
            })

            -- Autoformatting Setup
            require("conform").setup {
                formatters_by_ft = {
                    lua = { "stylua" },
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
        end,
    },
}
