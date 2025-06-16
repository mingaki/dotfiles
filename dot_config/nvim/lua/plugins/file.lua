return {
  {
    "stevearc/oil.nvim",
    version = "*",
    ---@module 'oil'
    ---@type oil.SetupOpts
    opts = {
      default_file_explorer = true,
      show_hidden = true,
    },
    -- Optional dependencies
    lazy = false,
    keys = {
      {
        "-",
        "<cmd>Oil<cr>",
        mode = "n",
        desc = "Open Parent Directory in Oil",
      },
    },
  },
  {
    "mikavilpas/yazi.nvim",
    dependencies = {
      "nvim-lua/plenary.nvim",
    },
    keys = {
      {
        "<leader>y",
        function()
          require("yazi").yazi()
        end,
        desc = "Yazi (Root Dir)",
      },
      {
        -- Open in the current working directory
        "<leader>Y",
        function()
          require("yazi").yazi(nil, vim.fn.getcwd())
        end,
        desc = "Yazi (cwd)",
      },
    },
  },
}
