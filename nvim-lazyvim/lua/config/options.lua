-- Options are automatically loaded before lazy.nvim startup
-- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua
-- Add any additional options here
local opt = vim.opt

opt.formatoptions = "jqlnt"
opt.cursorline = false
opt.shiftwidth = 4
opt.tabstop = 4

-- vim.g.python3_host_prog = vim.fn.expand("~/.pyenv/versions/neovim/bin/python")
vim.g.lazyvim_python_lsp = "pyright"
vim.g.lazyvim_python_ruff = "ruff"
vim.g.lazyvim_picker = "fzf"

vim.env.PATH = vim.env.HOME .. "/.local/share/mise/shims:" .. vim.env.PATH
