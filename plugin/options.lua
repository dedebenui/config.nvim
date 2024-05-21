local opt = vim.opt

----- Interesting Options -----

-- You have to turn this one on :)
opt.inccommand = "split"

-- Best search settings :)
opt.smartcase = true
opt.ignorecase = true

----- Personal Preferences -----
opt.number = true
opt.relativenumber = true
opt.scrolloff = 8

opt.splitbelow = true
opt.splitright = true

opt.signcolumn = "yes"
opt.shada = { "'10", "<0", "s10", "h" }

opt.tabstop = 4
opt.softtabstop = 4
opt.shiftwidth = 4
opt.expandtab = true

opt.smartindent = true
opt.linebreak = true
opt.clipboard = nil

vim.api.nvim_create_autocmd("FileType", {
    group = vim.api.nvim_create_augroup("CharqueAutocmd", { clear = true }),
    callback = function()
        for _, lang in pairs {
            "markdown",
            "text",
            "latex",
            "tex",
            "plaintex",
            "netrw",
            "help",
            "typst",
        } do
            if lang == vim.bo.filetype then
                vim.opt.wrap = true
                vim.opt.colorcolumn = ""
                return
            end
            vim.opt.colorcolumn = "101"
            vim.opt.wrap = false
        end
    end,
})

---- .vim plugins ----
vim.g.doge_doc_standard_python = "numpy"
vim.g.doge_python_settings = { single_quotes = 0, omit_redundant_param_types = 0 }
