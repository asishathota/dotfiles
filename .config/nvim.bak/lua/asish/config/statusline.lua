--==========================--
--====statusline====--
--==========================--

function _G.full_mode()
    local map = {
        n = "NORMAL",
        i = "INSERT",
        v = "VISUAL",
        V = "V-LINE",
        ["\22"] = "V-BLOCK",
        c = "COMMAND",
        R = "REPLACE",
        t = "TERMINAL",
    }
    return map[vim.api.nvim_get_mode().mode] or "?"
end

function _G.smart_path()
    local path = vim.fn.expand("%:~:.")
    if #path > 40 then
        path = "…" .. path:sub(-40)
    end
    return path
end

function _G.lsp_diagnostics()
    local d = vim.diagnostic
    local e = #d.get(0, { severity = d.severity.ERROR })
    local w = #d.get(0, { severity = d.severity.WARN })
    local h = #d.get(0, { severity = d.severity.HINT })
    local i = #d.get(0, { severity = d.severity.INFO })

    local res = {}
    if e > 0 then
        table.insert(res, " " .. e)
    end
    if w > 0 then
        table.insert(res, " " .. w)
    end
    if h > 0 then
        table.insert(res, " " .. h)
    end
    if i > 0 then
        table.insert(res, " " .. i)
    end
    return table.concat(res, " ")
end

vim.o.statusline = table.concat({
    " %{v:lua.full_mode()} ",
    " %<%{v:lua.smart_path()}%m%r ",
    -- " %<%t%m%r ",
    " %{v:lua.lsp_diagnostics()} ",
    " %= ",
    " %3p%%  %l:%c ",
    " %{strftime(' %H:%M')} ",
})
