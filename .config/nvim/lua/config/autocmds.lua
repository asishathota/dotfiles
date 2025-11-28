-- lsp keymaps
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

-- Check if we need to reload the file when it changed
vim.api.nvim_create_autocmd({ "FocusGained", "TermClose", "TermLeave" }, {
    group = vim.api.nvim_create_augroup("Checktime", { clear = true }),
    callback = function()
        if vim.o.buftype ~= "nofile" then
            vim.cmd("checktime")
        end
    end,
})

-- Highlight on yank
vim.api.nvim_create_autocmd("TextYankPost", {
    group = vim.api.nvim_create_augroup("YankHighlight", { clear = true }),
    pattern = "*",
    desc = "highlight selection on yank",
    callback = function()
        vim.highlight.on_yank({ timeout = 150, visual = true, higroup = "YankHighlight" })
    end,
})
vim.api.nvim_set_hl(0, "YankHighlight", { bg = "#696969", fg = "#FFFFFF" })

-- resize splits if window got resized
vim.api.nvim_create_autocmd({ "VimResized" }, {
    group = vim.api.nvim_create_augroup("resize_splits", { clear = true }),
    callback = function()
        local current_tab = vim.fn.tabpagenr()
        vim.cmd("tabdo wincmd =")
        vim.cmd("tabnext " .. current_tab)
    end,
})

--
vim.api.nvim_set_hl(0, "FloatBorder", { fg = "#0A64AC" })

-- go to last loc when opening a buffer
vim.api.nvim_create_autocmd("BufReadPost", {
    group = vim.api.nvim_create_augroup("last_loc", { clear = true }),
    callback = function(event)
        local exclude = { "gitcommit" }
        local buf = event.buf
        if vim.tbl_contains(exclude, vim.bo[buf].filetype) or vim.b[buf].lazyvim_last_loc then
            return
        end
        vim.b[buf].lazyvim_last_loc = true
        local mark = vim.api.nvim_buf_get_mark(buf, '"')
        local lcount = vim.api.nvim_buf_line_count(buf)
        if mark[1] > 0 and mark[1] <= lcount then
            pcall(vim.api.nvim_win_set_cursor, 0, mark)
        end
    end,
})

-- no auto coomenting when opening a new line
vim.api.nvim_create_autocmd("FileType", {
    group = vim.api.nvim_create_augroup("no_auto_comment", {}),
    callback = function()
        vim.opt_local.formatoptions:remove({ "c", "r", "o" })
    end,
})

-- close some filetypes with <q>
vim.api.nvim_create_autocmd("FileType", {
    group = vim.api.nvim_create_augroup("close_with_q", {}),
    pattern = {
        "PlenaryTestPopup",
        "checkhealth",
        "dbout",
        "gitsigns-blame",
        "grug-far",
        "help",
        "lspinfo",
        "neotest-output",
        "neotest-output-panel",
        "neotest-summary",
        "notify",
        "qf",
        "spectre_panel",
        "startuptime",
        "tsplayground",
    },
    callback = function(event)
        vim.bo[event.buf].buflisted = false
        vim.schedule(function()
            vim.keymap.set("n", "q", function()
                vim.cmd("close")
                pcall(vim.api.nvim_buf_delete, event.buf, { force = true })
            end, {
                buffer = event.buf,
                silent = true,
                desc = "Quit buffer",
            })
        end)
    end,
})

-- make it easier to close man-files when opened inline
vim.api.nvim_create_autocmd("FileType", {
    group = vim.api.nvim_create_augroup("man_unlisted", {}),
    pattern = { "man" },
    callback = function(event)
        vim.bo[event.buf].buflisted = false
    end,
})

-- wrap and check for spell in text filetypes
vim.api.nvim_create_autocmd("FileType", {
    group = vim.api.nvim_create_augroup("wrap_spell", {}),
    pattern = { "text", "plaintex", "typst", "gitcommit", "markdown" },
    callback = function()
        vim.opt_local.wrap = true
        vim.opt_local.spell = true
    end,
})

-- Fix conceallevel for json files
vim.api.nvim_create_autocmd({ "FileType" }, {
    group = vim.api.nvim_create_augroup("json_conceal", {}),
    pattern = { "json", "jsonc", "json5" },
    callback = function()
        vim.opt_local.conceallevel = 0
    end,
})

-- Auto create dir when saving a file, in case some intermediate directory does not exist
vim.api.nvim_create_autocmd({ "BufWritePre" }, {
    group = vim.api.nvim_create_augroup("auto_create_dir", {}),
    callback = function(event)
        if event.match:match("^%w%w+:[\\/][\\/]") then
            return
        end
        local file = vim.uv.fs_realpath(event.match) or event.match
        vim.fn.mkdir(vim.fn.fnamemodify(file, ":p:h"), "p")
    end,
})

-- notify the macro reading
local recording_augroup = vim.api.nvim_create_augroup("MacroRecordingGroup", { clear = true })
vim.api.nvim_create_autocmd("RecordingEnter", {
    group = recording_augroup,
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
    group = recording_augroup,
    callback = function()
        vim.notify("Macro Recording Stopped.", vim.log.levels.INFO, { title = "Noice" })
    end,
})

-- highlight the text inside documents
-- vim.api.nvim_create_autocmd("LspAttach", {
--     group = vim.api.nvim_create_augroup("kickstart-lsp-attach", { clear = true }),
--     callback = function(event)
--         local function client_supports_method(client, method, bufnr)
--             if vim.fn.has("nvim-0.11") == 1 then
--                 return client:supports_method(method, bufnr)
--             else
--                 return client.supports_method(method, { bufnr = bufnr })
--             end
--         end
--
--         local client = vim.lsp.get_client_by_id(event.data.client_id)
--         if
--             client
--             and client_supports_method(client, vim.lsp.protocol.Methods.textDocument_documentHighlight, event.buf)
--         then
--             vim.opt_local.updatetime = 3000
--             local highlight_augroup = vim.api.nvim_create_augroup("kickstart-lsp-highlight", { clear = false })
--             vim.api.nvim_create_autocmd({ "CursorHold", "CursorHoldI" }, {
--                 buffer = event.buf,
--                 group = highlight_augroup,
--                 callback = vim.lsp.buf.document_highlight,
--             })
--
--             vim.api.nvim_create_autocmd({ "CursorMoved", "CursorMovedI" }, {
--                 buffer = event.buf,
--                 group = highlight_augroup,
--                 callback = vim.lsp.buf.clear_references,
--             })
--
--             vim.api.nvim_create_autocmd("LspDetach", {
--                 group = vim.api.nvim_create_augroup("kickstart-lsp-detach", { clear = true }),
--                 callback = function(event2)
--                     vim.lsp.buf.clear_references()
--                     vim.api.nvim_clear_autocmds({ group = "kickstart-lsp-highlight", buffer = event2.buf })
--                 end,
--             })
--         end
--     end,
-- })
