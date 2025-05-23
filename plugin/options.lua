local function set_options()
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
    opt.equalalways = true

    opt.splitbelow = true
    opt.splitright = true

    opt.signcolumn = "yes"
    opt.shada = { "'10", "<0", "s10", "h" }
    opt.pumheight = 6

    opt.tabstop = 4
    opt.softtabstop = 4
    opt.shiftwidth = 4
    opt.expandtab = true
    -- opt.textwidth = 100

    opt.smartindent = true
    opt.breakindent = true
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
                    opt.wrap = true
                    opt.colorcolumn = ""
                    opt.smoothscroll = true
                    return
                end
            end
            opt.colorcolumn = "101"
            opt.wrap = false
        end,
    })

    ---- .vim plugins ----
    vim.g.doge_doc_standard_python = "numpy"
    vim.g.doge_python_settings = { single_quotes = 0, omit_redundant_param_types = 0 }

    --- file types ---
    vim.filetype.add { extension = { jinja = "jinja", j2 = "jinja", jinja2 = "jinja" } }
end

set_options()

vim.api.nvim_create_user_command("SetOpts", set_options, {})
vim.diagnostic.config { virtual_lines = { current_line = true }, virtual_text = false }
