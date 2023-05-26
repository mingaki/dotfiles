return {
  {
    "nvim-neo-tree/neo-tree.nvim",
    opts = {
      default_component_configs = {
        icon = {
          folder_empty = "󰜌",
          folder_empty_open = "󰜌",
        },
        git_status = {
          symbols = {
            renamed = "󰁕",
            unstaged = "󰄱",
          },
        },
      },
      document_symbols = {
        kinds = {
          File = { icon = "󰈙", hl = "Tag" },
          Namespace = { icon = "󰌗", hl = "Include" },
          Package = { icon = "󰏖", hl = "Label" },
          Class = { icon = "󰌗", hl = "Include" },
          Property = { icon = "󰆧", hl = "@property" },
          Enum = { icon = "󰒻", hl = "@number" },
          Function = { icon = "󰊕", hl = "Function" },
          String = { icon = "󰀬", hl = "String" },
          Number = { icon = "󰎠", hl = "Number" },
          Array = { icon = "󰅪", hl = "Type" },
          Object = { icon = "󰅩", hl = "Type" },
          Key = { icon = "󰌋", hl = "" },
          Struct = { icon = "󰌗", hl = "Type" },
          Operator = { icon = "󰆕", hl = "Operator" },
          TypeParameter = { icon = "󰊄", hl = "Type" },
          StaticMethod = { icon = "󰠄 ", hl = "Function" },
        },
      },
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
    dependencies = {
      "nvim-telescope/telescope-fzf-native.nvim",
      build = "make",
      config = function()
        require("telescope").load_extension("fzf")
      end,
    },
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
        mappings = {
          i = {
            ["<C-o>"] = function(prompt_bufnr)
              require("telescope.actions").select_default(prompt_bufnr)
              require("telescope.builtin").resume()
            end,
          },
        },
      },
    },
    keys = {
      { "<leader>sC", "<cmd>Telescope command_history<cr>", desc = "Command History" },
      { "<leader>sc", "<cmd>Telescope commands<cr>", desc = "Commands" },
    },
  },
  {
    "folke/trouble.nvim",
    keys = {
      { "<leader>xl", "<cmd>TroubleToggle loclist<cr>", desc = "Location List (Trouble)" },
      { "<leader>xq", "<cmd>TroubleToggle quickfix<cr>", desc = "Quickfix List (Trouble)" },
    },
  },
  {
    "windwp/nvim-spectre",
    -- stylua: ignore
    keys = {
      { "<leader>sr", function() require("spectre").open_file_search({select_word=true}) end, desc = "Replace in current file (Spectre)" },
      { "<leader>sR", function() require("spectre").open({select_word=true}) end, desc = "Replace in files (Spectre)" },
    },
  },
  {
    "mrjones2014/smart-splits.nvim",
    keys = {
      -- resize
      {
        "<C-Left>",
        function()
          require("smart-splits").resize_left()
        end,
        desc = "Resize window left",
      },
      {
        "<C-Down>",
        function()
          require("smart-splits").resize_down()
        end,
        desc = "Resize window down",
      },
      {
        "<C-Up>",
        function()
          require("smart-splits").resize_up()
        end,
        desc = "Resize window up",
      },
      {
        "<C-Right>",
        function()
          require("smart-splits").resize_right()
        end,
        desc = "Resize window right",
      },
      -- move
      {
        "<C-h>",
        function()
          require("smart-splits").move_cursor_left()
        end,
        desc = "Move cursor left",
      },
      {
        "<C-j>",
        function()
          require("smart-splits").move_cursor_down()
        end,
        desc = "Move cursor down",
      },
      {
        "<C-k>",
        function()
          require("smart-splits").move_cursor_up()
        end,
        desc = "Move cursor up",
      },
      {
        "<C-l>",
        function()
          require("smart-splits").move_cursor_right()
        end,
        desc = "Move cursor right",
      },
      -- swap
      {
        "<leader>wh",
        function()
          require("smart-splits").swap_buf_left()
        end,
        desc = "Swap buffer left",
      },
      {
        "<leader>wj",
        function()
          require("smart-splits").swap_buf_down()
        end,
        desc = "Swap buffer down",
      },
      {
        "<leader>wk",
        function()
          require("smart-splits").swap_buf_up()
        end,
        desc = "Swap buffer up",
      },
      {
        "<leader>wl",
        function()
          require("smart-splits").swap_buf_right()
        end,
        desc = "Swap buffer right",
      },
    },
  },
  {
    "Iron-E/nvim-bufmode",
    cmd = "BufmodeEnter",
    dependencies = {
      "Iron-E/nvim-libmodal",
      "akinsho/bufferline.nvim",
    },
    keys = { { "<leader>bm", "<cmd>BufmodeEnter<cr>", desc = "Enter buffer mode", mode = "n" } },
    opts = { bufferline = true, keymaps = { p = "BufferLineTogglePin", s = "BufferLinePick" } },
  },
}
