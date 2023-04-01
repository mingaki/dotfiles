return {
  {
    "nvim-neo-tree/neo-tree.nvim",
    opts = {
      filesystem = {
        filtered_items = {
          hide_dotfiles = false,
          always_show = { ".env" },
          never_show = { ".git", ".venv", "node_modules", ".DS_Store" },
          never_show_by_pattern = { "*cache" },
        },
      },
      window = {
        mappings = {
          ["l"] = {
            "open",
            nowait = false, -- disable `nowait` if you have existing combos starting with this char that you want to use
          },
          ["e"] = "focus_preview",
        },
      },
    },
  },
  {
    "nvim-telescope/telescope.nvim",
    opts = {
      pickers = {
        find_files = { hidden = true },
        live_grep = {
          additional_args = function(opts)
            return { "--hidden" }
          end,
        },
      },
      defaults = {
        file_ignore_patterns = { ".git/", "node_modules", ".venv" },
      },
    },
  },
  {
    "folke/trouble.nvim",
    keys = {
      { "<leader>xl", "<cmd>TroubleToggle loclist<cr>", desc = "Location List (Trouble)" },
      { "<leader>xq", "<cmd>TroubleToggle quickfix<cr>", desc = "Quickfix List (Trouble)" },
    },
  },
}
