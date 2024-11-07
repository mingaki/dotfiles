return {
  { -- Autocompletion
    "hrsh7th/nvim-cmp",
    event = "InsertEnter",
    dependencies = {
      -- Snippet Engine & its associated nvim-cmp source
      {
        "garymjr/nvim-snippets",
        opts = {
          friendly_snippets = true,
        },
        dependencies = { "rafamadriz/friendly-snippets" },
      },

      "hrsh7th/cmp-nvim-lsp",
      "hrsh7th/cmp-buffer",
      "hrsh7th/cmp-path",
    },
    opts = {
      completion = { completeopt = "menu,menuone,noinsert,noselect" },
      sources = {
        {
          name = "lazydev",
          -- set group index to 0 to skip loading LuaLS completions as lazydev recommends it
          group_index = 0,
        },
        { name = "nvim_lsp" },
        { name = "snippets" },
        { name = "path" },
        { name = "buffer" },
      },
    },
    config = function(_, opts)
      -- See `:help cmp`
      local cmp = require("cmp")

      -- For an understanding of why these mappings were
      -- chosen, you will need to read `:help ins-completion`
      --
      -- No, but seriously. Please read `:help ins-completion`, it is really good!
      opts["mapping"] = cmp.mapping.preset.insert({
        -- Select the [n]ext item
        ["<C-n>"] = cmp.mapping.select_next_item({ behavior = cmp.SelectBehavior.Insert }),
        -- Select the [p]revious item
        ["<C-p>"] = cmp.mapping.select_prev_item({ behavior = cmp.SelectBehavior.Insert }),

        -- Scroll the documentation window [b]ack / [f]orward
        ["<C-b>"] = cmp.mapping.scroll_docs(-4),
        ["<C-f>"] = cmp.mapping.scroll_docs(4),

        -- Accept ([y]es) the completion.
        --  This will auto-import if your LSP supports it.
        --  This will expand snippets if the LSP sent a snippet.
        ["<C-y>"] = cmp.mapping.confirm({ select = true }),

        -- If you prefer more traditional completion keymaps,
        -- you can uncomment the following lines
        ["<CR>"] = cmp.mapping.confirm({ select = true }),
        --['<Tab>'] = cmp.mapping.select_next_item(),
        --['<S-Tab>'] = cmp.mapping.select_prev_item(),
      })
      cmp.setup(opts)
    end,
    keys = {
      {
        "<Tab>",
        function()
          return vim.snippet.active({ direction = 1 }) and "<cmd>lua vim.snippet.jump(1)<cr>" or "<Tab>"
        end,
        expr = true,
        silent = true,
        mode = { "i", "s" },
      },
      {
        "<S-Tab>",
        function()
          return vim.snippet.active({ direction = -1 }) and "<cmd>lua vim.snippet.jump(-1)<cr>" or "<S-Tab>"
        end,
        expr = true,
        silent = true,
        mode = { "i", "s" },
      },
    },
  },
  {
    "folke/ts-comments.nvim",
    version = "*",
    event = "VeryLazy",
    opts = {},
  },
  {
    "danymat/neogen",
    keys = {
      {
        "<leader>cG",
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
        "<leader>cg",
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
}
