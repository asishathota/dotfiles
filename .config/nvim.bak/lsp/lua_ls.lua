return {
    settings = {
        Lua = {
            runtime = {
                version = "Lua 5.3",
            },
            diagnostics = {
                globals = { "vim" },
            },
            hint = { enable = true },
            workspace = {
                library = {
                    [vim.fn.expand("$VIMRUNTIME/lua")] = true,
                    [vim.fn.stdpath("config") .. "/lua"] = true,
                },
                checkThirdParty = false,
            },
            telemetry = {
                enable = false,
            },
        },
    },
}
