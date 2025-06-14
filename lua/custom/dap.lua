local dap = require "dap"
local ui = require "dapui"

require("dapui").setup()
require("nvim-dap-virtual-text").setup()

for _, ft_path in ipairs(vim.api.nvim_get_runtime_file("lua/custom/dap-configs/*.lua", true)) do
    loadfile(ft_path)()
end

vim.keymap.set("n", "<space>b", dap.toggle_breakpoint)
vim.keymap.set("n", "<space>gb", dap.run_to_cursor)

-- Eval var under cursor
vim.keymap.set("n", "<space>?", function() require("dapui").eval(nil, { enter = true }) end)

vim.keymap.set("n", "<F1>", dap.continue)
vim.keymap.set("n", "<F2>", dap.step_into)
vim.keymap.set("n", "<F3>", dap.step_over)
vim.keymap.set("n", "<F4>", dap.step_out)
vim.keymap.set("n", "<F5>", dap.step_back)
vim.keymap.set("n", "<F8>", dap.restart)
vim.keymap.set("n", "<F12>", function()
    dap.terminate()
    ui.close()
end)

dap.listeners.before.attach.dapui_config = function() ui.open() end
dap.listeners.before.launch.dapui_config = function() ui.open() end

vim.api.nvim_set_hl(0, "DapBreakpoint", { ctermbg = 0, fg = "#ff0000", bg = "" })
vim.fn.sign_define(
    "DapBreakpoint",
    { text = "", texthl = "DapBreakpoint", linehl = "", numhl = "" }
)
vim.fn.sign_define(
    "DapStopped",
    { text = "➡", texthl = "String", linehl = "DiffAdd", numhl = "" }
)
