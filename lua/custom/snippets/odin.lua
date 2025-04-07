require("luasnip.session.snippet_collection").clear_snippets "python"

local ls = require "luasnip"

local s = ls.snippet
local i = ls.insert_node
local t = ls.text_node
local f = ls.function_node

ls.add_snippets("odin", {
    s("fori", {
        t { "for i := 0; i < " },
        i(1),
        t { "; i += 1 {", "    " },
        i(0),
        t { "", "}" },
    }),
})
