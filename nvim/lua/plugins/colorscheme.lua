return {
  {
    "EdenEast/nightfox.nvim",
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
      },
    },
  },
  {
    "folke/tokyonight.nvim",
    opts = {
      styles = {
        keywords = { italic = true, bold = true },
      },
      on_highlights = function(hl, c)
        hl["@keyword.function"].style = {
          bold = true,
          italic = true,
        }
      end,
    },
  },
}
