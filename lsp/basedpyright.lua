return {
    cmd = { "basedpyright-langserver", "--stdio" },
    filetypes = { "python" },
    single_file_support = true,
    settings = {
        basedpyright = {
            disableOrganizeImports = true,
            analysis = {
                diagnosticMode = "openFilesOnly",
                typeCheckingMode = "off",
                autoSearchPaths = true,
                useLibraryCodeForTypes = true,
                exclude = { { ".venv" } },
            },
            venvPath = ".",
            venv = ".venv",
        },
    },
    root_markers = {
        "pyproject.toml",
        "setup.py",
        "setup.cfg",
        "requirements.txt",
        "Pipfile",
        "pyrightconfig.json",
        ".git",
    },
}
