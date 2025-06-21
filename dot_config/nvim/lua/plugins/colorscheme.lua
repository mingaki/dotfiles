return {
  "EdenEast/nightfox.nvim",
  -- version = "*",
  lazy = false,
  priority = 1000,
  opts = {
    options = {
      transparent = true,
      styles = {
        keywords = "italic,bold",
      },
    },
    groups = {
      all = {
        NeoTreeNormal = { bg = "bg1" },
        ["@keyword.function"] = {
          style = "italic,bold",
        },
      },
      dayfox = {
        LspReferenceText = { bg = "#cfd1c9" },
      },
      dawnfox = {
        Type = { fg = "#8f7738" },
        NeoTreeGitModified = { fg = "#b0995b" },
        FzfLuaHeaderBind = { fg = "#a0c46e" },
        FzfLuaPathLineNr = { fg = "#a0c46e" },
        FzfLuaTabMarker = { fg = "#a0c46e" },
        FzfLuaCursorLine = { fg = "#5b7082", bg = "#ebdfe4" },
        LspReferenceRead = { bg = "#e2e6d8" },
        LspReferenceWrite = { bg = "#e2e6d8" },
        LspReferenceText = { bg = "#e2e6d8" },
        WarningMsg = { fg = "#d49e53" },
      },
    },
  },
  config = function(opts, _)
    -- somehow setting this in opts.group doesn't work..
    vim.api.nvim_create_autocmd({ "FileType" }, {
      pattern = { "help" },
      callback = function()
        vim.api.nvim_set_hl(0, "@markup.raw.block", { fg = "#8f7367" })
        vim.api.nvim_set_hl(0, "@markup.raw.block.markdown", { fg = "#8f7367" })
        vim.api.nvim_set_hl(0, "@markup.raw.block.vimdoc", { fg = "#8f7367" })
      end,
    })

    require("nightfox").setup(opts)
    vim.cmd([[colorscheme dawnfox]])
  end,
}
