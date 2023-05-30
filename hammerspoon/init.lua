local M = { pid = nil }

function M.getKittyApp()
	if M.pid then
		local app = hs.application.get(M.pid)
		if app and app:isRunning() then
			return app
		end
	end
	local f = io.popen("pgrep -af scratchpad")
	local ret = f:read("*a")
	f:close()
	M.pid = tonumber(ret)
	return M.pid and hs.application.get(M.pid)
end

M.toggle = function()
	local app = M.getKittyApp()
	if app then
		if app:isFrontmost() then
			print("kitty: hide")
			app:hide()
		else
			print("kitty: focus")
			local win = app:mainWindow()
			win:focus()
		end
	else
		print("kitty: launch")
		os.execute(
			"/Applications/kitty.app/Contents/MacOS/kitty --listen-on 'unix:/tmp/kitty_scratch' -d ~ --title scratchpad -1 --instance-group scratchpad -o macos_hide_from_tasks=yes -o macos_quit_when_last_window_closed=yes &"
		)
	end
end

hs.hotkey.bind({ "cmd" }, "escape", "Scratchpad", M.toggle)
