vim.opt.completeopt = { "menu", "menuone", "noselect" }
vim.opt.shortmess:append "c"

local lspkind = require "lspkind"
lspkind.init {}

local cmp = require "cmp"

cmp.setup {
    sources = {
        { name = "calc" },
        { name = "lazydev" },
        { name = "nvim_lsp" },
        { name = "luasnip" },
        {
            name = "path",
            option = {
                get_cwd = function() return vim.fn.getcwd() end,
            },
        },
        { name = "buffer" },
    },
    mapping = {
        ["<C-n>"] = cmp.mapping.select_next_item { behavior = cmp.SelectBehavior.Insert },
        ["<C-p>"] = cmp.mapping.select_prev_item { behavior = cmp.SelectBehavior.Insert },
        ["<C-i>"] = cmp.mapping(
            cmp.mapping.confirm {
                behavior = cmp.ConfirmBehavior.Insert,
                select = true,
            },
            { "i", "c" }
        ),
    },

    -- Enable luasnip to handle snippet expansion for nvim-cmp
    snippet = {
        expand = function(args) require("luasnip").lsp_expand(args.body) end,
    },
}

local ls = require "luasnip"
ls.config.set_config {
    history = false,
    updateevents = "TextChanged,TextChangedI",
    enable_autosnippets = true,
}

for _, ft_path in ipairs(vim.api.nvim_get_runtime_file("lua/custom/snippets/*.lua", true)) do
    loadfile(ft_path)()
end

vim.keymap.set({ "i", "s" }, "<c-k>", function()
    if ls.expand_or_jumpable() then ls.expand_or_jump() end
end, { silent = true, desc = "expand or jump in snippet" })

vim.keymap.set({ "i", "s" }, "<c-j>", function()
    if ls.jumpable(-1) then ls.jump(-1) end
end, { silent = true })

-- https://github.com/L3MON4D3/LuaSnip/issues/797#issuecomment-1970013181
local untrigger = function()
    -- get the snippet
    local snip = ls.session.current_nodes[vim.api.nvim_get_current_buf()].parent.snippet
    -- get its trigger
    local trig = snip.trigger
    -- replace that region with the trigger
    local node_from, node_to = snip.mark:pos_begin_end_raw()
    vim.api.nvim_buf_set_text(0, node_from[1], node_from[2], node_to[1], node_to[2], { trig })
    -- reset the cursor-position to ahead the trigger
    vim.fn.setpos(".", { 0, node_from[1] + 1, node_from[2] + 1 + string.len(trig) })
end

vim.keymap.set({ "i", "s" }, "<c-x>", function()
    if ls.in_snippet() then
        untrigger()
        ls.unlink_current()
    end
end, {
    desc = "Undo a snippet",
})
