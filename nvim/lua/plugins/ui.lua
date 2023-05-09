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
      options = {
        always_show_bufferline = true,
      },
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
  {
    "folke/noice.nvim",
    opts = {
      routes = {
        { filter = { event = "msg_show", find = "; before #%d+" }, skip = true },
        { filter = { event = "msg_show", find = "; after #%d+" }, skip = true },
        { filter = { event = "msg_show", find = "Downloaded ipynb file" }, skip = true },
        { filter = { event = "msg_show", find = "search hit" }, skip = true },
        {
          filter = {
            event = "msg_show",
            find = "%d+L, %d+B",
          },
          view = "mini",
        },
      },
    },
  },
  {
    "nvim-lualine/lualine.nvim",
    opts = function(_, opts)
      opts.options.component_separators = { left = "", right = "" }
      opts.options.section_separators = { left = "", right = "" }
      table.remove(opts.sections.lualine_c)
    end,
  },
}
