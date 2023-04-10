local mode = Get_system_mode()
local theme = Get_mode_theme(mode)

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
