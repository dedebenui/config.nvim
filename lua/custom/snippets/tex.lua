require("luasnip.session.snippet_collection").clear_snippets "tex"

local ls = require "luasnip"

local s = ls.snippet
local i = ls.insert_node
local t = ls.text_node
local f = ls.function_node
local d = ls.dynamic_node
local sn = ls.snippet_node

local function copy_text(args) return args[1][1] end
local function copy_node(args) return sn(nil, { i(1, args[1]) }) end

ls.add_snippets("tex", {
    s("begin", {
        t [[\begin{]],
        i(1),
        t { "}", "    " },
        i(0),
        t { "", [[\end{]] },
        f(copy_text, { 1 }),
        t { "}", "" },
    }),
    s("equation", {
        t { [[\begin{equation}]], "    " },
        i(0),
        t { "", [[\end{equation}]] },
    }),
    s("figure", {
        t { [[\begin{figure}]], [[   \centering]], [[   \includegraphics[width=0.95\linewidth]{]] },
        i(1),
        t { [[}]], [[    \caption{]] },
        i(0),
        t { [[}]], [[    \label{fig:]] },
        i(2),
        t { [[}]], [[\end{figure}]] },
    }),
    s("acronym", {
        t [[\DeclareAcronym{]],
        i(1),
        t { [[}{]], [[   short = ]] },
        d(2, copy_node, { 1 }),
        t { [[ ,]], [[   long = ]] },
        i(3),
        t { "", [[}]] },
    }),
})
