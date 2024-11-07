return {
  "EdenEast/nightfox.nvim",
  version = "*",
  lazy = true,
  opts = {
    options = {
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
      },
    },
  },
}
