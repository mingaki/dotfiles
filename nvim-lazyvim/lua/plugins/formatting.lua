return {
    {
        "stevearc/conform.nvim",
        opts = function(_, opts)
            opts.formatters_by_ft.python = function(bufnr)
                if require("conform").get_formatter_info("ruff_format", bufnr).available then
                    return { "ruff_format" }
                else
                    return { "isort", "black" }
                end
            end
        end,
    },
}
