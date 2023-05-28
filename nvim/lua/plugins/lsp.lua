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
        "flake8",
        "ruff",
        "black",
        "pyright",
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
