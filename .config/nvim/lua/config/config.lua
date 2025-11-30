-- highlight current line number
vim.api.nvim_set_hl(0, "LineNr", { fg = "#B4D0E9", bold = true })

-- highlight when yanking
vim.api.nvim_set_hl(0, "YankHighlight", { bg = "#696969", fg = "#FFFFFF" })

-- highlight the borders
vim.api.nvim_set_hl(0, "FloatBorder", { fg = "#0DB9D7" })

-- vim.diagnostic.config({
--     severity_sort = true,
--     float = { border = "rounded", source = "if_many" },
--     underline = { severity = vim.diagnostic.severity.ERROR },
--     update_in_insert = false,
--     -- 󰅚 󰀪 󰋽 󰌶
--     signs = {
--         text = {
--             [vim.diagnostic.severity.ERROR] = " ",
--             [vim.diagnostic.severity.WARN] = " ",
--             [vim.diagnostic.severity.INFO] = " ",
--             [vim.diagnostic.severity.HINT] = " ",
--         },
--     } or {},
--     virtual_text = {
--         source = "if_many",
--         severity = { min = vim.diagnostic.severity.WARN },
--         -- ■ 
--         spacing = 2,
--         format = function(diagnostic)
--             local diagnostic_message = {
--                 [vim.diagnostic.severity.ERROR] = diagnostic.message,
--                 [vim.diagnostic.severity.WARN] = diagnostic.message,
--                 [vim.diagnostic.severity.INFO] = diagnostic.message,
--                 [vim.diagnostic.severity.HINT] = diagnostic.message,
--             }
--             return " " .. diagnostic_message[diagnostic.severity]
--             -- return " " .. diagnostic.message .. " "
--         end,
--     },
-- })
