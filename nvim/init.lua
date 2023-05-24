-- bootstrap lazy.nvim, LazyVim and your plugins

if vim.g.vscode then
  vim.keymap.set("n", "H", "<cmd>Tabprevious<CR>")
  vim.keymap.set("n", "L", "<cmd>Tabnext<CR>")
  return
else
  require("config.lazy")
end
