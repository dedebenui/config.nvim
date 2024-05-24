require("luasnip.session.snippet_collection").clear_snippets "tex"

local ls = require "luasnip"

local s = ls.snippet
local i = ls.insert_node
local t = ls.text_node
local f = ls.function_node

local function copy_node(args) return args[1][1] end

ls.add_snippets("tex", {
    s("begin", {
        t [[\begin{]],
        i(1),
        t { "}", "    " },
        i(0),
        t { "", [[\end{]] },
        f(copy_node, { 1 }),
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
})
