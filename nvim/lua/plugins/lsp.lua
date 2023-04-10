return {
  {
    "b0o/SchemaStore.nvim",
    version = false, -- last release is way too old
  },
  {
    "neovim/nvim-lspconfig",
    opts = {
      diagnostics = {
        virtual_text = false,
      },
      servers = {
        pyright = {
          settings = {
            python = {
              analysis = {
                typeCheckingMode = "off",
              },
            },
          },
        },
        jsonls = {
          -- lazy-load schemastore when needed
          on_new_config = function(new_config)
            new_config.settings.json.schemas = new_config.settings.json.schemas or {}
            vim.list_extend(new_config.settings.json.schemas, require("schemastore").json.schemas())
          end,
          settings = {
            json = {
              format = {
                enable = true,
              },
              validate = { enable = true },
            },
          },
        },
      },
    },
  },
  {

    "williamboman/mason.nvim",
    cmd = "Mason",
    opts = {
      ensure_installed = {
        "stylua",
        "shfmt",
        "flake8",
        "pyright",
        "black",
      },
    },
    {
      "jose-elias-alvarez/null-ls.nvim",
      event = { "BufReadPre", "BufNewFile" },
      dependencies = { "mason.nvim" },
      opts = function()
        local nls = require("null-ls")
        return {
          root_dir = require("null-ls.utils").root_pattern(".null-ls-root", ".neoconf.json", "Makefile", ".git"),
          sources = {
            nls.builtins.formatting.fish_indent,
            nls.builtins.diagnostics.fish,
            nls.builtins.formatting.stylua,
            nls.builtins.formatting.shfmt,
            nls.builtins.formatting.black,
            nls.builtins.diagnostics.flake8,
          },
        }
      end,
    },
  },
}
