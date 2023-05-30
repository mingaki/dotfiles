Daynight_mode = "day"
local filepath = "~/.config/state.yml"

function Get_system_mode()
  local mode
  local handle = io.popen("yq '.mode' < " .. filepath)
  if handle then
    local output = handle:read("*a")
    mode = output:gsub("[\n%s]+$", "")
    handle:close()
  end
  return mode
end

function Get_mode_theme(mode)
  local mode_themes = { day = "zenbones", night = "seoulbones" }
  local theme = mode_themes[mode]
  if not theme then
    theme = "dayfox"
  end
  return theme
end

function Set_background(mode)
  if mode == "day" then
    vim.cmd("set background=light")
  else
    vim.cmd("set background=dark")
  end
end

function Set_mode(mode)
  local theme = Get_mode_theme(mode)
  local current_theme = vim.g.colors_name
  if current_theme ~= theme then
    vim.cmd("colorscheme " .. theme)
  end
  Set_background(mode)
  Daynight_mode = mode
end

function Toggle_mode()
  if Daynight_mode == "day" then
    Set_mode("night")
  else
    Set_mode("day")
  end
  os.execute("sketchybar --trigger sync_daynight")
end

function Sync_mode()
  local sys_mode = Get_system_mode()
  Set_mode(sys_mode)
end

return {
  {
    "LazyVim/LazyVim",
    opts = {
      colorscheme = function()
        Sync_mode()
      end,
    },
  },
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
        dayfox = {
          LspReferenceText = { bg = "#cfd1c9" },
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
  {
    "catppuccin/nvim",
    name = "catppuccin",
    opts = {
      flavour = "frappe",
      background = { -- :h background
        light = "frappe",
        dark = "frappe",
      },
      styles = {
        keywords = { "italic", "bold" },
      },
      custom_highlights = function(colors)
        return {
          ["@keyword.function"] = { style = { "italic", "bold" } },
        }
      end,
    },
  },
  {
    "mcchrish/zenbones.nvim",
    dependencies = { "rktjmp/lush.nvim" },
  },
}
