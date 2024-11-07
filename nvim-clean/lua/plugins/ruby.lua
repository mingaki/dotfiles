return {
  -- {
  --   "nvim-treesitter/nvim-treesitter",
  --   opts = { ensure_installed = { "ruby" } },
  -- },
  {
    "neovim/nvim-lspconfig",
    opts = {
      servers = {
        ruby_lsp = {},
        rubocop = {},
      },
    },
  },
  {
    "stevearc/conform.nvim",
    opts = {
      formatters_by_ft = {
        ruby = { "rubocop" },
      },
    },
  },
  opts = {
    adapters = {
      ["neotest-rspec"] = {
        -- NOTE: By default neotest-rspec uses the system wide rspec gem instead of the one through bundler
        -- rspec_cmd = function()
        --   return vim.tbl_flatten({
        --     "bundle",
        --     "exec",
        --     "rspec",
        --   })
        -- end,
      },
    },
  },
  "olimorris/neotest-rspec",
}
