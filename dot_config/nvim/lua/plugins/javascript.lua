return {
  {
    "nvim-treesitter/nvim-treesitter",
    opts = { ensure_installed = { "python", "ninja", "rst" } },
  },
  {
    "neovim/nvim-lspconfig",
    opts = {
      servers = {
        ts_ls = {},
      },
    },
  },
  {
    "stevearc/conform.nvim",
    opts = {
      formatters_by_ft = {
        javascript = { "prettierd" },
        javascriptreact = { "prettierd" },
      },
    },
  },
}
