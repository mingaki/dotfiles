return {
  {
    "neovim/nvim-lspconfig",
    opts = {
      -- diagnostics = {
      --   virtual_text = false,
      -- },
    },
    init = function()
      local keys = require("lazyvim.plugins.lsp.keymaps").get()
      keys[#keys + 1] = { "gl", vim.diagnostic.open_float, desc = "Diagnostic" }
    end,
  },
  {

    "williamboman/mason.nvim",
    cmd = "Mason",
    opts = {
      ensure_installed = {
        -- python
        "ruff",
        "black",
        -- lua
        "lua-language-server",
        "stylua",
        -- shell
        "shellcheck",
        "shfmt",
      },
    },
    {
      "jose-elias-alvarez/null-ls.nvim",
      event = { "BufReadPre", "BufNewFile" },
      dependencies = { "mason.nvim" },
      opts = function(_, opts)
        local nls = require("null-ls")
        local sources = {
          nls.builtins.formatting.isort,
          nls.builtins.formatting.black,
          nls.builtins.diagnostics.ruff,
        }
        for index, value in ipairs(sources) do
          table.insert(opts.sources, value)
        end
      end,
    },
  },
}
