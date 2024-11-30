require("luasnip.session.snippet_collection").clear_snippets "jinja"

local ls = require "luasnip"

local s = ls.snippet
local i = ls.insert_node
local t = ls.text_node
local f = ls.function_node
local function copy_text(args) return args[1][1] end
local function copy_newline(args)
    if args[1][1]:sub(1, 1) == "\n" then return "\n    " end
end

ls.add_snippets("jinja", {
    s("block", {
        t [[{% block ]],
        i(1),
        t { [[ %}]], "    " },
        i(0),
        f(copy_newline, { 0 }),
        t { "", [[{% endblock %}]] },
    }),
})
