Daynight_mode = "day"
local filepath = "~/.config/state.yml"

function Get_system_mode()
  local mode = "fuck"
  local handle = io.popen("yq '.mode' < " .. filepath)
  if handle then
    local output = handle:read("*a")
    mode = output:gsub("[\n%s]+$", "")
    handle:close()
  end
  return mode
end

function Get_mode_theme(mode)
  local mode_themes = { day = "dayfox", night = "tokyonight-moon" }
  local theme = mode_themes[mode]
  if not theme then
    theme = "dayfox"
  end
  return theme
end

local function set_mode(mode)
  local theme = Get_mode_theme(mode)
  vim.cmd("colorscheme " .. theme)
  Daynight_mode = mode
end

function Toggle_mode()
  if Daynight_mode == "day" then
    set_mode("night")
  else
    set_mode("day")
  end
  os.execute("sketchybar --trigger sync_daynight")
end

function Sync_mode()
  local sys_mode = Get_system_mode()
  set_mode(sys_mode)
end

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
