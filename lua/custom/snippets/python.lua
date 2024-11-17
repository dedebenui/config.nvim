require("luasnip.session.snippet_collection").clear_snippets "python"

local ls = require "luasnip"

local s = ls.snippet
local i = ls.insert_node
local t = ls.text_node
local f = ls.function_node
local function copy_text(args) return args[1][1] end

ls.add_snippets("python", {
    s("main()", {
        t { "def main():", "    " },
        i(0),
        t { "", "", [[if __name__ == "__main__":]], "    main()" },
    }),
    s("creator", {
        t "metadata=dict(Creator=os.fspath(Path(sys.argv[0]).resolve()))",
    }),
    s("plot-no-y", {
        i(1, "ax"),
        t { [[.spines["left"].set_visible(False)]], "" },
        f(copy_text, { 1 }),
        t { [[.tick_params(labelleft=False, left=False)]], "" },
    }),
    s("plot-no-x", {
        i(1, "ax"),
        t { [[.spines["bottom"].set_visible(False)]], "" },
        f(copy_text, { 1 }),
        t { [[.tick_params(labelbottom=False, bottom=False)]], "" },
    }),
})
