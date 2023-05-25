return {
  {
    "stevearc/aerial.nvim",
    config = function()
      require("aerial").setup({
        on_attach = function(bufnr)
          vim.api.nvim_buf_set_keymap(bufnr, "n", "<leader>fa", "<cmd>AerialToggle!<CR>", { desc = "Toggle Aerial" })
          -- Jump forwards/backwards with '{' and '}'
          vim.api.nvim_buf_set_keymap(bufnr, "n", "{", "<cmd>AerialPrev<CR>", { desc = "Prev Item in Aerial" })
          vim.api.nvim_buf_set_keymap(bufnr, "n", "}", "<cmd>AerialNext<CR>", { desc = "Next Item in Aerial" })
        end,

        layout = {
          min_width = { 35, 0.2 },
          max_width = { 40, 0.5 },
        },
      })
    end,
  },
  {
    "danymat/neogen",
    keys = {
      {
        "<leader>cC",
        function()
          local neogen = require("neogen")
          local filetype = vim.bo.filetype
          local convention = vim.fn.input("Covention for " .. filetype .. ": ")
          if neogen.conventions ~= nil then
            neogen.conventions[filetype] = convention
          else
            neogen.conventions = { [filetype] = convention }
          end
        end,
        desc = "Neogen set convention",
      },
      {
        "<leader>cc",
        function()
          local neogen = require("neogen")
          if neogen.conventions ~= nil then
            neogen.generate({ annotation_convention = neogen.conventions })
          else
            neogen.generate({})
          end
        end,
        desc = "Neogen Comment",
      },
    },
    opts = { snippet_engine = "luasnip" },
  },
  {
    "windwp/nvim-autopairs",
    event = "VeryLazy",
    vscode = true,
    config = function()
      require("nvim-autopairs").setup({})
    end,
  },
  {
    "kylechui/nvim-surround",
    version = "*", -- Use for stability; omit to use `main` branch for the latest features
    event = "VeryLazy",
    vscode = true,
    config = function()
      require("nvim-surround").setup({
        keymaps = {
          visual = "z",
        },
      })
    end,
  },
  {
    "hrsh7th/nvim-cmp",
    opts = function(_, opts)
      local cmp = require("cmp")
      opts.sources = cmp.config.sources(vim.list_extend(opts.sources, { { name = "jupynium", priority = 1000 } }))
      opts.formatting = {
        format = function(entry, item)
          local icons = require("lazyvim.config").icons.kinds
          if icons[item.kind] then
            item.kind = icons[item.kind] .. item.kind
          end
          item.menu = ({
            buffer = "[Buffer]",
            nvim_lsp = "[LSP]",
            luasnip = "[LuaSnip]",
            nvim_lua = "[Lua]",
            latex_symbols = "[LaTeX]",
            jupynium = "[Jupynium]",
          })[entry.source.name]
          return item
        end,
      }
      opts.completion.completeopt = opts.completion.completeopt .. ",noselect"
      opts.preselect = cmp.PreselectMode.None
    end,
  },
}
