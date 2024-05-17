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
set("n", "j", "gj")
set("n", "k", "gk")

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

-- Save/quit
set("n", "<leader>w", "<CMD>w<CR>", { desc = "Write current buffer" })
set("n", "<leader>qw", "<CMD>wqa<CR>", { desc = "Save all and exit" })

-- RUN
set("n", "<leader>rp", [[<CMD>w<CR><CMD>!python "%"<CR>]], { desc = "Run python" })
