return {
  {
    "uga-rosa/ccc.nvim",
    keys = {
      { "<leader>uh", "<cmd>CccHighlighterToggle<CR>", desc = "Toggle Highlighter" },
    },
    event = "VeryLazy",
    opts = { highlighter = {
      auto_enable = true,
      lsp = true,
    } },
  },
  {
    "sindrets/diffview.nvim",
    cmd = { "DiffviewOpen", "DiffviewClose", "DiffviewToggleFiles", "DiffviewFocusFiles" },
    config = true,
    keys = { { "<leader>gd", "<cmd>DiffviewOpen<cr>", desc = "DiffView" } },
  },
}
