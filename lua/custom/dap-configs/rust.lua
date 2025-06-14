local dap = require "dap"

dap.adapters.lldb = {
    type = "server",
    port = "${port}",
    executable = { command = "codelldb", args = { "--port", "${port}" }, detached = false },
    name = "lldb",
}

dap.configurations.rust = {
    {
        name = "run-example",
        type = "lldb",
        request = "launch",
        program = function()
            vim.cmd.w()
            local example_name = vim.fs.basename(vim.fn.expand "%:r")
            if 0 ~= os.execute("cargo build --example " .. example_name .. " > /dev/null 2>&1") then
                return dap.ABORT
            end
            return "./target/debug/examples/" .. example_name
        end,
        cwd = "${workspaceFolder}",
        stopOnEntry = false,
    },
    {
        name = "run-main",
        type = "lldb",
        request = "launch",
        program = "./target/debug/nu",
        args = {
            "-n",
            "--no-std-lib",
            "-c",
            "1e32",
        },
        cwd = "${workspaceFolder}",
        stopOnEntry = false,
    },
}
