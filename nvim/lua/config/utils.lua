M = {}

local filepath = "~/.config/state.yml"

function M.get_system_mode()
  local mode = "fuck"
  local handle = io.popen("yq '.mode' < " .. filepath)
  if handle then
    local output = handle:read("*a")
    mode = output:gsub("[\n%s]+$", "")
    handle:close()
  end
  return mode
end

function M.set_mode(mode)
  M.mode = mode
  local mode_table = { day = "dayfox", night = "nordfox" }

  M.theme = mode_table[mode]
  if not M.theme then
    M.theme = "dayfox"
  end

  vim.cmd("colorscheme " .. M.theme)
end

function M.toggle_mode()
  if M.mode == "day" then
    M.mode = "night"
  else
    M.mode = "day"
  end
  M.set_mode(M.mode)
  os.execute("sketchybar --trigger sync_daynight")
end

function M.sync_mode()
  local sys_mode = M.get_system_mode()
  M.set_mode(sys_mode)
end

return M
