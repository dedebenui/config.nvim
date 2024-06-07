local dap = require "dap"

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
            command = "python",
            args = { "-m", "debugpy.adapter" },
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
    },
}
