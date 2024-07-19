require("luasnip.session.snippet_collection").clear_snippets "python"

local ls = require "luasnip"

local s = ls.snippet
local i = ls.insert_node
local t = ls.text_node

ls.add_snippets("python", {
    s("main()", {
        t { "def main():", "   " },
        i(0),
        t { "", "", [[if __name__ == "__main__":]], "    main()" },
    }),
    s("creator", {
        t "metadata=dict(Creator=os.fspath(Path(__file__).resolve()))",
    }),
})
