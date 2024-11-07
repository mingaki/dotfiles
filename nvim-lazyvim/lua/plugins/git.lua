return {
    {
        "sindrets/diffview.nvim",
        cmd = { "DiffviewOpen", "DiffviewToggleFiles", "DiffviewFocusFiles", "DiffviewFileHistory" },
        config = true,
        keys = { { "<leader>gd", "<cmd>DiffviewOpen<cr>", desc = "DiffView" } },
    },
    { "tpope/vim-fugitive" },
}
