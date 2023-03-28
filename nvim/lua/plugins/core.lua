local utils = require("config.utils")
local mode = utils.get_system_mode()
local theme = utils.mode_table[mode]

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
