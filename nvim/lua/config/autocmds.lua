-- Autocmds are automatically loaded on the VeryLazy event
-- Default autocmds that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/autocmds.lua
-- Add any additional autocmds here

vim.api.nvim_create_autocmd({ "FocusGained" }, {
  callback = function()
    Sync_mode()
  end,
  nested = true, -- trigger highlight for other plugins
})

vim.api.nvim_create_autocmd("ColorScheme", {
  pattern = { "seoulbones", "zenbones" },
  callback = function()
    if vim.o.background == "light" then
      vim.api.nvim_set_hl(0, "NeoTreeGitConflict", { bold = true, italic = true, fg = "#be6a84" })
      vim.api.nvim_set_hl(0, "NeoTreeGitUntracked", { italic = true, fg = "#be6a84" })
      vim.api.nvim_set_hl(0, "NeoTreeDirectoryIcon", { fg = "#8898b5" })
      vim.api.nvim_set_hl(0, "NotifyINFOIcon", { fg = "#749169" })
      vim.api.nvim_set_hl(0, "NotifyINFOTitle", { fg = "#749169" })
    end
    local statement_fg = vim.api.nvim_get_hl(0, { name = "Statement" }).fg
    vim.api.nvim_set_hl(0, "@keyword.function", { bold = true, italic = true, fg = statement_fg })
    vim.api.nvim_set_hl(0, "@keyword", { bold = true, italic = true, fg = statement_fg })
    vim.api.nvim_set_hl(0, "@string", { link = "String" })

    -- neotest
    vim.api.nvim_set_hl(0, "NeotestFailedxxx", { link = "Error" })
    vim.api.nvim_set_hl(0, "NeotestDir", { link = "NeoTreeDirectoryText" })
    vim.api.nvim_set_hl(0, "NeotestFile", { link = "NeotestDir" })
    vim.api.nvim_set_hl(0, "NeotestNamespace", { link = "NeotestDir" })
    vim.api.nvim_set_hl(0, "NeotestAdapterName", { bold = true, italic = true })
    vim.api.nvim_set_hl(0, "NeotestRunning", { link = "WarningMsg" })
    vim.api.nvim_set_hl(0, "NeotestPassed", { link = "MoreMsg" })
    vim.api.nvim_set_hl(0, "NeotestFailed", { link = "Error" })
    vim.api.nvim_set_hl(0, "NeotestMarked", { link = "GitSignsAdd" })
    vim.api.nvim_set_hl(0, "NeotestTarget", { link = "Statement" })
    vim.api.nvim_set_hl(0, "NeotestSkipped", { link = "NeoTreeDotfile" })
    vim.api.nvim_set_hl(0, "NeotestWinselect", { link = "NeoTreeDotfile" })
  end,
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
