-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here
-- Close buffers
local Util = require("lazyvim.util")

local function map(mode, lhs, rhs, opts)
    local keys = require("lazy.core.handler").handlers.keys
    ---@cast keys LazyKeysHandler
    -- do not create the keymap if a lazy keys handler exists
    if not keys.active[keys.parse({ lhs, mode = mode }).id] then
        opts = opts or {}
        opts.silent = opts.silent ~= false
        vim.keymap.set(mode, lhs, rhs, opts)
    end
end

if Util.has("mini.bufremove") then
    map("n", "<S-q>", function()
        require("mini.bufremove").delete(0, false)
    end, { desc = "Delete Buffer" })
else
    map("n", "<S-q>", "<cmd>bd<CR>", { desc = "Delete Buffer" })
end

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
