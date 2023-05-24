-- local mode = Get_system_mode()
-- local theme = Get_mode_theme(mode)
-- Set_mode(mode)

return {
  {
    "LazyVim/LazyVim",
    opts = {
      colorscheme = "seoulbones",
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
