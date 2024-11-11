return {
  { "folke/lazy.nvim", version = "*" },
  {
    "folke/persistence.nvim",
    version = "*",
    event = "BufReadPre",
    opts = {},
    -- stylua: ignore
    keys = {
      { "<leader>qs", function() require("persistence").load() end, desc = "Restore Session" },
      { "<leader>qS", function() require("persistence").select() end,desc = "Select Session" },
      { "<leader>ql", function() require("persistence").load({ last = true }) end, desc = "Restore Last Session" },
      { "<leader>qd", function() require("persistence").stop() end, desc = "Don't Save Current Session" },
    },
  },
  {
    "shortcuts/no-neck-pain.nvim",
    version = "*",
    lazy = false,
    opts = {
      width = 120,
      autocmds = {
        enableOnVimEnter = true,
        enabledOnTabEnter = true,
        skipEnteringNoNeckPainBuffer = true,
      },
      buffers = {
        scratchPad = {
          -- set to `false` to
          -- disable auto-saving
          enabled = false,
          -- set to `nil` to default
          -- to current working directory
          location = nil,
        },
      },
    },
    cond = function()
      return vim.env.KITTY_SCROLLBACK_NVIM ~= "true"
    end,
    keys = {
      { "<leader>N", "<cmd>NoNeckPain<CR>", desc = "Toggle NoNeckPain" },
      { "<leader>uN", "<cmd>NoNeckPain<CR>", desc = "Toggle NoNeckPain" },
    },
  },
  {
    "uga-rosa/ccc.nvim",
    keys = {
      { "<leader>uH", "<cmd>CccHighlighterToggle<CR>", desc = "Toggle Highlighter" },
    },
    opts = { highlighter = {
      lsp = true,
    } },
  },
  {
    "mikesmithgh/kitty-scrollback.nvim",
    enabled = true,
    lazy = true,
    cmd = { "KittyScrollbackGenerateKittens", "KittyScrollbackCheckHealth" },
    event = { "User KittyScrollbackLaunch" },
    -- version = '*', -- latest stable version, may have breaking changes if major version changed
    -- version = '^4.0.0', -- pin major version, include fixes and features that do not have breaking changes
    config = function()
      require("kitty-scrollback").setup()
    end,
  },
}
