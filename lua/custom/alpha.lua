local alpha = require "alpha"
local dashboard = require "alpha.themes.dashboard"

-- Set header
-- dashboard.section.header.val = {
--     "                                                     ",
--     "  ███╗   ██╗███████╗ ██████╗ ██╗   ██╗██╗███╗   ███╗ ",
--     "  ████╗  ██║██╔════╝██╔═══██╗██║   ██║██║████╗ ████║ ",
--     "  ██╔██╗ ██║█████╗  ██║   ██║██║   ██║██║██╔████╔██║ ",
--     "  ██║╚██╗██║██╔══╝  ██║   ██║╚██╗ ██╔╝██║██║╚██╔╝██║ ",
--     "  ██║ ╚████║███████╗╚██████╔╝ ╚████╔╝ ██║██║ ╚═╝ ██║ ",
--     "  ╚═╝  ╚═══╝╚══════╝ ╚═════╝   ╚═══╝  ╚═╝╚═╝     ╚═╝ ",
--     "                                                     ",
-- }
-- dashboard.section.header.val = {
--     "     ▄   ▄███▄   ████▄     ▄   ▄█ █▀▄▀█   ",
--     "      █  █▀   ▀  █   █      █  ██ █ █ █   ",
--     "  ██   █ ██▄▄    █   █ █     █ ██ █ ▄ █   ",
--     "  █ █  █ █▄   ▄▀ ▀████  █    █ ▐█ █   █   ",
--     "  █  █ █ ▀███▀           █  █   ▐    █    ",
--     "  █   ██                  █▐        ▀     ",
--     "                          ▐  ",
-- }
dashboard.section.header.val = {
    "   ███▄    █ ▓█████  ▒█████   ██▒   █▓ ██▓ ███▄ ▄███▓  ",
    "   ██ ▀█   █ ▓█   ▀ ▒██▒  ██▒▓██░   █▒▓██▒▓██▒▀█▀ ██▒  ",
    "  ▓██  ▀█ ██▒▒███   ▒██░  ██▒ ▓██  █▒░▒██▒▓██    ▓██░  ",
    "  ▓██▒  ▐▌██▒▒▓█  ▄ ▒██   ██░  ▒██ █░░░██░▒██    ▒██   ",
    "  ▒██░   ▓██░░▒████▒░ ████▓▒░   ▒▀█░  ░██░▒██▒   ░██▒  ",
    "  ░ ▒░   ▒ ▒ ░░ ▒░ ░░ ▒░▒░▒░    ░ ▐░  ░▓  ░ ▒░   ░  ░  ",
    "  ░ ░░   ░ ▒░ ░ ░  ░  ░ ▒ ▒░    ░ ░░   ▒ ░░  ░      ░  ",
    "     ░   ░ ░    ░   ░ ░ ░ ▒       ░░   ▒ ░░      ░     ",
    "           ░    ░  ░    ░ ░        ░   ░         ░     ",
    "                                  ░                    ",
}

-- Set menu
dashboard.section.buttons.val = {
    dashboard.button("e", "  > NeoTree", ":Neotree reveal toggle float<CR>"),
    dashboard.button("f", "󰍉  > Find file", ":Telescope find_files<CR>"),
    dashboard.button("n", "  > New file", ":ene <BAR> startinsert <CR>"),
    dashboard.button(
        "h",
        "󰀱  > Harpoon",
        [[:lua require("harpoon.ui"):toggle_quick_menu(require("harpoon"):list())<CR>]]
    ),
    dashboard.button("r", "  > Recent", ":Telescope oldfiles<CR>"),
    dashboard.button(
        "s",
        "  > Settings",
        [[:lua require("telescope.builtin").find_files({cwd = vim.fn.stdpath "config"})<CR>]]
    ),
    dashboard.button("q", "  > Quit NVIM", ":qa<CR>"),
}

-- Send config to alpha
alpha.setup(dashboard.opts)

-- Disable folding on alpha buffer
vim.cmd [[
    autocmd FileType alpha setlocal nofoldenable
]]
