local dap = require "dap"

---get arguments one by one from the user.
---Remembers the last one given per buffer
local function get_args()
    local prev_args = vim.b.python_dap_args or {}
    local args = {}
    local i = 1
    local canceled = false
    while true do
        vim.ui.input({
            prompt = "Arguments: ",
            default = prev_args[i] or "",
        }, function(input)
            if input == nil then
                canceled = true
                return
            end
            args[i] = input
        end)
        if canceled then return nil end
        if args[i] == "" then
            args[i] = nil
            break
        end
        i = i + 1
    end
    vim.b.python_dap_args = args
    return args
end

dap.adapters.python = function(cb, config)
    if config.request == "attach" then
        ---@diagnostic disable-next-line: undefined-field
        local port = (config.connect or config).port
        ---@diagnostic disable-next-line: undefined-field
        local host = (config.connect or config).host or "127.0.0.1"
        cb {
            type = "server",
            port = assert(port, "`connect.port` is required for a python `attach` configuration"),
            host = host,
            options = {
                source_filetype = "python",
            },
        }
    else
        cb {
            type = "executable",
            command = "uv",
            args = { "run", "python", "-m", "debugpy.adapter" },
            options = {
                source_filetype = "python",
            },
        }
    end
end
dap.configurations.python = {
    {
        type = "python",
        request = "launch",
        name = "Launch file",
        -- adapter-spcific options:
        program = "${file}",
        cwd = function()
            local project_dir = vim.fn.input {
                prompt = "Working directory: ",
                default = vim.fn.getcwd() .. "/",
                completion = "dir",
            }
            if project_dir == nil or project_dir == "" then return dap.ABORT end
            return project_dir
        end,
        args = function() return get_args() or dap.ABORT end,
    },
}
