return {
    {
        "neovim/nvim-lspconfig",
        opts = {
            -- 1. Disable all auto inlay hints from LazyVim
            inlay_hints = {
                enabled = false,
            },

            -- 2. Disable snippet support from ALL LSP servers
            servers = {
                ["*"] = {
                    capabilities = {
                        textDocument = {
                            completion = {
                                completionItem = {
                                    snippetSupport = false,
                                },
                            },
                        },
                    },
                },
            },
        },
    },
}
