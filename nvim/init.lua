-- bootstrap lazy.nvim, LazyVim and your plugins

if vim.g.vscode then
  return
else
  require("config.lazy")
end
