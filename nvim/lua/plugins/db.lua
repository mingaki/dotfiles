return {
    "kristijanhusak/vim-dadbod-ui",
    dependencies = {
        { "tpope/vim-dadbod", lazy = true },
        { "kristijanhusak/vim-dadbod-completion", ft = { "sql", "mysql", "plsql" }, lazy = true },
    },
    cmd = {
        "DBUI",
        "DBUIToggle",
        "DBUIAddConnection",
        "DBUIFindBuffer",
    },
    init = function()
        -- Your DBUI configuration
        vim.g.db_ui_use_nerd_fonts = 1
        vim.api.nvim_set_hl(0, "NotificationInfo", { link = "DiagnosticInfo" })
        vim.api.nvim_set_hl(0, "NotificationError", { link = "DiagnosticError" })
        vim.api.nvim_set_hl(0, "NotificationWarning", { link = "DiagnosticWarn" })
    end,
}
