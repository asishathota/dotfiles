vim.api.nvim_create_autocmd("TextYankPost", {
    group = vim.api.nvim_create_augroup("YankHighlight", { clear = true }),
    pattern = "*",
    desc = "highlight selection on yank",
    callback = function()
        vim.highlight.on_yank({ timeout = 150, visual = true, higroup = "YankHighlight" })
    end,
})
vim.api.nvim_set_hl(0, "YankHighlight", { bg = "#696969", fg = "#FFFFFF" })

vim.api.nvim_create_autocmd("VimResized", {
    command = "wincmd =",
})

vim.api.nvim_create_autocmd("FileType", {
    group = vim.api.nvim_create_augroup("no_auto_comment", {}),
    callback = function()
        vim.opt_local.formatoptions:remove({ "c", "r", "o" })
    end,
})

vim.api.nvim_create_autocmd("BufRead", {
    group = vim.api.nvim_create_augroup("dotenv_ft", { clear = true }),
    pattern = { ".env", ".env.*" },
    callback = function()
        vim.bo.filetype = "dosini"
    end,
})

-- notify the macro reading
local recording_augroup = vim.api.nvim_create_augroup("MacroRecordingGroup", { clear = true })

vim.api.nvim_create_autocmd("RecordingEnter", {
    group = recording_augroup, -- Assign it to the group
    callback = function()
        local reg_name = vim.fn.reg_recording()
        if reg_name ~= "" then
            vim.notify("Macro Recording Started in register @" .. reg_name, vim.log.levels.INFO, { title = "Noice" })
        else
            vim.notify("Macro Recording Started!", vim.log.levels.INFO, { title = "Noice" })
        end
    end,
})

vim.api.nvim_create_autocmd("RecordingLeave", {
    group = recording_augroup, -- Assign this one too
    callback = function()
        vim.notify("Macro Recording Stopped.", vim.log.levels.INFO, { title = "Noice" })
    end,
})

-- set spell checking for text/markdown
vim.api.nvim_create_autocmd("FileType", {
    pattern = { "markdown" },
    callback = function()
        vim.opt_local.spell = true
        vim.opt_local.spelllang = { "en_us" }
    end,
})

vim.api.nvim_create_autocmd("LspAttach", {
    group = vim.api.nvim_create_augroup("kickstart-lsp-attach", { clear = true }),
    callback = function(event)
        local function client_supports_method(client, method, bufnr)
            if vim.fn.has("nvim-0.11") == 1 then
                return client:supports_method(method, bufnr)
            else
                return client.supports_method(method, { bufnr = bufnr })
            end
        end

        local client = vim.lsp.get_client_by_id(event.data.client_id)
        if
            client
            and client_supports_method(client, vim.lsp.protocol.Methods.textDocument_documentHighlight, event.buf)
        then
            vim.opt_local.updatetime = 3000
            local highlight_augroup = vim.api.nvim_create_augroup("kickstart-lsp-highlight", { clear = false })
            vim.api.nvim_create_autocmd({ "CursorHold", "CursorHoldI" }, {
                buffer = event.buf,
                group = highlight_augroup,
                callback = vim.lsp.buf.document_highlight,
            })

            vim.api.nvim_create_autocmd({ "CursorMoved", "CursorMovedI" }, {
                buffer = event.buf,
                group = highlight_augroup,
                callback = vim.lsp.buf.clear_references,
            })

            vim.api.nvim_create_autocmd("LspDetach", {
                group = vim.api.nvim_create_augroup("kickstart-lsp-detach", { clear = true }),
                callback = function(event2)
                    vim.lsp.buf.clear_references()
                    vim.api.nvim_clear_autocmds({ group = "kickstart-lsp-highlight", buffer = event2.buf })
                end,
            })
        end
    end,
})

vim.api.nvim_create_autocmd("LspAttach", {
    group = vim.api.nvim_create_augroup("UserLspConfig", {}),
    callback = function(event)
        local map = function(keys, func, desc, mode)
            mode = mode or "n"
            vim.keymap.set(mode, keys, func, { buffer = event.buf, desc = "LSP: " .. desc })
        end

        map("gr", "<cmd>Telescope lsp_references<CR>", "Show LSP references")
        map("gD", vim.lsp.buf.declaration, "Go to declaration")
        map("gd", vim.lsp.buf.definition, "Show LSP definition")
        map("gi", "<cmd>Telescope lsp_implementations<CR>", "Show LSP implementations")
        map("gt", "<cmd>Telescope lsp_type_definitions<CR>", "Show LSP type definitions")
        map("<leader>ca", vim.lsp.buf.code_action, "See available code actions", { "n", "v" })
        map("<leader>rn", vim.lsp.buf.rename, "Smart rename")
        map("<leader>D", "<cmd>Telescope diagnostics bufnr=0<CR>", "Show buffer diagnostics")
        map("<leader>d", vim.diagnostic.open_float, "Show line diagnostics")
        map("[d", function()
            vim.diagnostic.jump({ count = -1, float = true })
        end, "Go to previous diagnostic")
        map("]d", function()
            vim.diagnostic.jump({ count = 1, float = true })
        end, "Go to next diagnostic")
        map("K", vim.lsp.buf.hover, "Show documentation for what is under cursor")
        map("<leader>rs", ":LspRestart<CR>", "Restart LSP")
    end,
})
