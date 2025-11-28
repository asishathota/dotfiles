return {
    "stevearc/conform.nvim",
    event = { "BufReadPre", "BufNewFile" },
    config = function()
        require("conform").setup({
            formatters_by_ft = {
                javascript = { "prettier" },
                typescript = { "prettier" },
                javascriptreact = { "prettier" },
                typescriptreact = { "prettier" },
                svelte = { "prettier" },
                css = { "prettier" },
                html = { "prettier" },
                json = { "prettier" },
                yaml = { "prettier" },
                markdown = { "prettier" },
                graphql = { "prettier" },
                liquid = { "prettier" },
                lua = { "stylua" },
                python = { "isort", "black" },
                -- java = { "google-java-format" },
            },
            format_on_save = {
                lsp_fallback = true,
                async = false,
                timeout_ms = 500,
            },
            formatters = {
                prettier = {
                    prepend_args = function()
                        return {
                            "--stdin-filepath",
                            "$FILENAME",
                            "--use-tabs",
                            "false",
                            "--single-quote",
                            "--print-width=120",
                            "--tab-width=4",
                            "--semi=true",
                            "--jsx-single-quote=false",
                        }
                    end,
                },
            },
        })

        vim.keymap.set({ "n", "v" }, "<leader>mp", function()
            require("conform").format({
                lsp_fallback = true,
                async = false,
                timeout_ms = 1000,
            })
        end)
    end,
}
