require("luasnip.session.snippet_collection").clear_snippets "tex"

local ls = require "luasnip"

local SNIPPET = ls.snippet

local c = ls.choice_node
local d = ls.dynamic_node
local f = ls.function_node
local i = ls.insert_node
local r = ls.restore_node
local sn = ls.snippet_node
local t = ls.text_node

local function copy_text(args) return args[1][1] end
local function copy_node(args) return sn(nil, { i(1, args[1]) }) end
local function if_not_empty(str)
    return function(args)
        if args[1][1] ~= "" then
            return str
        else
            return ""
        end
    end
end

local snips = {
    SNIPPET("\\begin", {
        t "\\begin{",
        i(1),
        t { "}", "    " },
        i(0),
        t { "", "\\end{" },
        f(copy_text, { 1 }),
        t { "}", "" },
    }),
    SNIPPET("equation", {
        t { "\\begin{equation}", "    " },
        i(0),
        t { "", "\\end{equation}" },
    }),
    SNIPPET("figure", {
        t { "\\begin{figure}", "   \\centering", "   \\includegraphics[width=\\linewidth]{" },
        i(1),
        t { "}", "    \\caption{" },
        i(0),
        t { "}", "    \\label{fig:" },
        i(2),
        t { "}", "\\end{figure}" },
    }),
    SNIPPET("acronym", {
        t "\\DeclareAcronym{",
        i(1),
        t { "}{", "   short = " },
        d(3, copy_node, { 1 }),
        t { " ,", "   long = " },
        i(2),
        t { "", "}" },
    }),
    SNIPPET("fig", {
        t "Fig.~\\ref{fig:",
        i(1),
        t "}",
    }),
    SNIPPET("eqref", {
        t "Eq.~(\\ref{eq:",
        i(1),
        t "})",
    }),
    SNIPPET("mathrm", {
        i(1),
        f(if_not_empty "_", { 1 }),
        t "\\mathrm{",
        i(2),
        t "}",
    }),
    SNIPPET("symbol", {
        t "\\",
        i(1),
        f(if_not_empty "_{", { 2 }),
        i(2),
        f(if_not_empty "}", { 2 }),
        f(if_not_empty "^{", { 3 }),
        i(3),
        f(if_not_empty "}", { 3 }),
    }),
    SNIPPET("leftright", {
        c(1, {
            sn(nil, { t "\\left(", r(1, "content"), t "\\right)" }),
            sn(nil, { t "\\left[", r(1, "content"), t "\\right]" }),
            sn(nil, { t "\\left\\{", r(1, "content"), t "\\right\\}" }),
        }),
    }, { stored = { ["content"] = i(1) } }),
    SNIPPET({ trig = "SI", name = "SI unit" }, {
        t "$\\SI{",
        i(1),
        t "}{",
        i(2),
        t "}$",
    }),
    SNIPPET("frac", {
        t "\\frac{",
        i(1),
        t "}{",
        i(2),
        t "}",
    }),
}

ls.add_snippets("tex", snips)
ls.add_snippets("plaintex", snips)
vim.keymap.set(
    { "i", "v" },
    "<C-l>",
    function() ls.change_choice(1) end,
    { desc = "Choice node next choice" }
)
