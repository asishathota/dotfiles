return {
    "brenoprata10/nvim-highlight-colors",
    event = { "BufReadPre", "BufNewFile", "InsertEnter" },
    config = function()
        vim.opt.termguicolors = true
        require("nvim-highlight-colors").setup({
            render = "virtual",
            virtual_symbol = "",
            virtual_symbol_position = "inline",
            enable_tailwind = true,
            enable_rgb = true,
            enable_hex = true,
            enable_named_colors = true,
            enable_var_usage = true,
            enable_hsl = true,
        })
    end,
}

--    ◍ svelte-language-server svelte (keywords: svelte)
--    ◍ jdtls (keywords: java)
--    ◍ emmet-language-server emmet_language_server (keywords: emmet)
--    ◍ css-lsp cssls (keywords: css, scss, less)
--    ◍ html-lsp html (keywords: html)
--    ◍ lua-language-server lua_ls (keywords: lua)
--    ◍ stylua (keywords: lua, luau)
--    ◍ tailwindcss-language-server tailwindcss (keywords: css)
--    ◍ typescript-language-server ts_ls (keywords: typescript, javascript)
