local set = vim.keymap.set

-- Basic movement keybinds, these make navigating splits easy for me
set("n", "<c-j>", "<c-w><c-j>")
set("n", "<c-k>", "<c-w><c-k>")
set("n", "<c-l>", "<c-w><c-l>")
set("n", "<c-h>", "<c-w><c-h>")

-- Move selected lines around
set("v", "J", ":m '>+1<CR>gv=gv")
set("v", "K", ":m '<-2<CR>gv=gv")

-- center view when performing common cursor movements
set("n", "J", "mzJ`z", { desc = "move next line to end of this one" })
set("n", "<C-d>", "<C-d>zz", { desc = "center view when jumping down" })
set("n", "<C-u>", "<C-u>zz", { desc = "center view when jumping up" })
set("n", "<C-o>", "<C-o>zz", { desc = "center view when jumping back" })
set("n", "<C-i>", "<C-i>zz", { desc = "center view when jumping ahead" })
set("n", "G", "Gzz", { desc = "center view when jumping to bottom of buffer" })
set("n", "n", "nzzzv")
set("n", "N", "Nzzzv")
set({ "n", "v" }, "j", "gj")
set({ "n", "v" }, "k", "gk")

-- Delete/paste without messing current register
set("v", "<leader>p", [["_dP]])
set("v", "<leader>y", [["+y]])
set("v", "<leader>d", [["_d]])

set("n", "Q", "<nop>")
set("i", "kj", "<Esc>")
set("i", "<C-d>", "<C-k>")

-- Search/replace shortcuts
set("n", "<leader>sa", "ggVG", { desc = "select all" })
set(
    "n",
    "<leader>sg",
    [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]],
    { desc = "replace every occurence of <word> in the current buffer" }
)
set(
    "n",
    "<leader>sl",
    "#*cgn",
    { desc = "replace word under cursor after putting it in search buffer" }
)
set("n", "<leader>su", [[_"9yy"9pv$r-]], { desc = "underline current line with dashes" })
set("n", "<leader>sr", "<Cmd>noh<CR>", { desc = "reset search buffer highlight" })
set("n", "<leader>a", "ea")
set("n", "<leader>A", "$i")

-- Save/quit
set("n", "<leader>w", "<CMD>wa<CR>", { desc = "Write all buffers" })
set("n", "<leader>qw", "<CMD>wqa<CR>", { desc = "Save all and exit" })

--- LSP ---
set("n", "gd", vim.lsp.buf.definition, { desc = "Go to definition" })
set("n", "gr", vim.lsp.buf.references, { desc = "Show references" })
set("n", "gD", vim.lsp.buf.declaration, { desc = "Go to declaration" })
set("n", "gT", vim.lsp.buf.type_definition, { desc = "Go to type definition" })
set("n", "g<C-j>", vim.diagnostic.goto_next, { desc = "Next diagnostic" })
set("n", "g<C-k>", vim.diagnostic.goto_prev, { desc = "Previous diagnostic" })
set("n", "K", vim.lsp.buf.hover, { desc = "Hover help" })
set("n", "<leader>cr", vim.lsp.buf.rename, { desc = "Rename symbol" })
set("n", "<leader>ca", vim.lsp.buf.code_action, { desc = "Code action" })
set("i", "<C-h>", vim.lsp.buf.signature_help, { desc = "Signature help" })

--- RUN ---
local function conclude(obj)
    if obj.code ~= 0 then
        vim.notify(obj.stderr, vim.log.levels.ERROR)
    else
        vim.notify(obj.stdout, vim.log.levels.INFO)
    end
end

local function run_python()
    vim.cmd "w"
    local obj = vim.system({ "uv", "run", vim.fn.expand "%" }, { text = true }):wait()
    conclude(obj)
end

local function compile_typst()
    vim.cmd "w"
    local obj = vim.system({ "typst", "compile", vim.fn.expand "%" }, { text = true }):wait()
    conclude(obj)
end
set("n", "<leader>rp", run_python, { desc = "Run python" })
set("n", "<leader>rt", compile_typst, { desc = "Run python" })
set("n", "<leader>rl", [[<CMD>w<CR><CMD>!latexmk<CR><CR>]], { desc = "Run LaTeX" })
