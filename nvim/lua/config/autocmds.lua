-- Autocmds are automatically loaded on the VeryLazy event
-- Default autocmds that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/autocmds.lua
-- Add any additional autocmds here

vim.api.nvim_create_autocmd({ "FocusGained" }, {
	callback = function()
		Sync_mode()
	end,
	nested = true, -- trigger highlight for other plugins
})

vim.api.nvim_create_autocmd("FileType", {
	group = "lazyvim_close_with_q",
	pattern = {
		"aerial",
		"aerial-nav",
	},
	callback = function(event)
		vim.bo[event.buf].buflisted = false
		vim.keymap.set("n", "q", "<cmd>close<cr>", { buffer = event.buf, silent = true })
	end,
})
