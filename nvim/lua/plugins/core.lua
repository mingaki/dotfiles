local mode = require("config.utils").get_system_mode()
local mode_table = { day = "dayfox", night = "nordfox" }
local theme = mode_table[mode]

return {
  {
    "LazyVim/LazyVim",
    opts = {
      colorscheme = theme,
      icons = {
        diagnostics = {
          Error = " ",
          Warn = " ",
          Hint = " ",
          Info = " ",
        },
      },
    },
  },
}
