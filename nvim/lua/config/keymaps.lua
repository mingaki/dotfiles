-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here
-- Close buffers
local map = LazyVim.safe_keymap_set

map("n", "<S-q>", LazyVim.ui.bufremove, { desc = "Delete Buffer" })

map("n", "<F8>", "<cmd>lua os.execute('sleep 0.1'); Sync_mode()<CR>")
map("n", "<leader>gg", "<cmd>lua os.execute('$MY_BINS/tmux-toggle-lazygit.sh')<CR>", { desc = "Lazygit" })

map("n", "]<tab>", "<cmd>tabnext<cr>", { desc = "Next Tab" })
map("n", "[<tab>", "<cmd>tabprevious<cr>", { desc = "Previous Tab" })

vim.api.nvim_del_keymap("i", "<A-j>")
vim.api.nvim_del_keymap("i", "<A-k>")

if vim.g.vscode then
    vim.keymap.set("n", "H", "<cmd>Tabprevious<CR>")
    vim.keymap.set("n", "L", "<cmd>Tabnext<CR>")
end
