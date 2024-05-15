return {
    "nvim-treesitter/nvim-treesitter-context",
    opts = {
        on_attach = function(bufnr)
            local ft = vim.bo[bufnr].filetype
            return (ft ~= "markdown") and (ft ~= "quarto")
        end,
    },
}
