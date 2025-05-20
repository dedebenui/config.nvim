return {
    cmd = { "ruff", "server" },
    filetypes = { "python" },
    on_attach = function(client, _)
        if client.name == "ruff" then client.server_capabilities.hoverProvider = false end
    end,
}
