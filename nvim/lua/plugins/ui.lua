return {
  {
    "petertriho/nvim-scrollbar",
    opts = {},
  },
  {
    "utilyre/barbecue.nvim",
    name = "barbecue",
    version = "*",
    dependencies = {
      "SmiteshP/nvim-navic",
      "nvim-tree/nvim-web-devicons", -- optional dependency
    },
    opts = {},
  },
  {
    "akinsho/bufferline.nvim",
    opts = {
      highlights = {
        offset_separator = {
          fg = {
            highlight = "WinSeparator",
            attribute = "fg",
          },
          bg = {
            highlight = "separator",
            attribute = "bg",
          },
        },
      },
    },
  },
}
