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
                sourcekit = { cmd = { "sourcekit-lsp" }, manual_install = true },
                clangd = {
                    init_options = { clangdFileStatus = true },
                    filetypes = { "c" },
                },
                cssls = true,
                ltex = {
                    filetype = {
                        "gitcommit",
                        "latex",
                        "markdown",
                        "tex",
                        "plaintex",
                        "text",
                        "typst",
                    },
                },
                lua_ls = true,
                nushell = {
                    manual_install = true,
                    filetype = { "nu" },
                    cmd = { "nu", "--lsp" },
                    root_dir = lspconfig.util.find_git_ancestor,
                    single_file_support = true,
                },
                pyright = {
                    settings = {
                        pyright = { disableOrganizeImports = true },
                        python = { analysis = { typeCheckingMode = "off" } },
                    },
                },
                ruff = {
                    -- cmd = {
                    --     vim.fn.expand "~/localcode/ruff/target/release/ruff",
                    --     "server",
                    --     "--preview",
                    -- },
                    on_attach = function(client, _)
                        if client.name == "ruff" then
                            -- Disable hover in favor of Pyright
                            client.server_capabilities.hoverProvider = false
                        end
                    end,
                },
                rust_analyzer = true,
                taplo = {
                    settings = {
                        evenBetterToml = {
                            schema = {
                                catalogs = { "https://taplo.tamasfe.dev/schema_index.json" },
                            },
                        },
                    },
                },
                texlab = true,
                tinymist = true,
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
                "codelldb",
                "cpptools",
                "tinymist",
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
        end,
    },
}
