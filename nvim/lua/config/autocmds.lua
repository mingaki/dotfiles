-- Autocmds are automatically loaded on the VeryLazy event
-- Default autocmds that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/autocmds.lua
-- Add any additional autocmds here

vim.api.nvim_create_autocmd({ "FocusGained", "VimEnter" }, {
  callback = function()
    require("config.utils").sync_mode()
  end,
  nested = true, -- trigger highlight for other plugins
})
