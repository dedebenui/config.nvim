require("luasnip.session.snippet_collection").clear_snippets "python"

local ls = require "luasnip"

local s = ls.snippet
local i = ls.insert_node
local t = ls.text_node

local fmt = require("luasnip.extras.fmt").fmt

ls.add_snippets("python", { s("LOL", { t "def main" }) })
