local terms = {}

local function create_float_term(cmd, count)
  local Terminal = require("toggleterm.terminal").Terminal
  local term = Terminal:new({
    cmd = cmd,
    hidden = true,
    direction = "float",
    on_open = function(term)
      vim.api.nvim_buf_set_keymap(term.bufnr, "t", "q", "<cmd>close<CR>", { noremap = true, silent = true })
      vim.api.nvim_buf_set_keymap(term.bufnr, "t", "<esc>", "<esc>", { nowait = true })
    end,
    count = count,
  })
  return term
end

local toggleterm_table = {
  "akinsho/toggleterm.nvim",
  version = "*",
  opts = {
    open_mapping = [[<c-\>]],
    shade_terminals = false,
    persist_size = true,
    persist_mode = true,
    insert_mappings = true,
    start_in_insert = true,
    close_on_exit = true,
    direction = "horizontal",
  },
  config = function(_, opts)
    opts.size = function(term)
      if term.direction == "horizontal" then
        return vim.o.lines * 0.4
      elseif term.direction == "vertical" then
        return vim.o.columns * 0.45
      end
    end
    opts.float_opts = {
      border = "curved",
      height = math.floor(vim.o.lines * 0.9),
      width = math.floor(vim.o.columns * 0.95),
    }
    require("toggleterm").setup(opts)

    -- autocmds
    function _G.set_terminal_keymaps()
      local map_opts = { noremap = true }
      vim.api.nvim_buf_set_keymap(0, "t", "<C-h>", [[<C-\><C-n><C-W>h]], map_opts)
      vim.api.nvim_buf_set_keymap(0, "t", "<C-j>", [[<C-\><C-n><C-W>j]], map_opts)
      vim.api.nvim_buf_set_keymap(0, "t", "<C-k>", [[<C-\><C-n><C-W>k]], map_opts)
      vim.api.nvim_buf_set_keymap(0, "t", "<C-l>", [[<C-\><C-n><C-W>l]], map_opts)
    end

    vim.cmd("autocmd! TermOpen term://* lua set_terminal_keymaps()")
    vim.cmd("autocmd! BufEnter term://* startinsert")

    -- create terms
    terms.lazygit = create_float_term("lazygit", 5)
    terms.lazydocker = create_float_term("lazydocker", 6)
    local Terminal = require("toggleterm.terminal").Terminal
    terms.python = Terminal:new({
      cmd = "ipython --matplotlib",
      hidden = true,
      direction = "vertical",
      count = 7,
    })
  end,
  keys = {
    {
      "<C-\\>",
      desc = "ToggleTerm",
    },
    {
      "<leader>t",
      desc = "Toggle+",
    },
    {
      "<leader>gg",
      function()
        terms.lazygit:toggle()
      end,
      desc = "lazygit",
    },
    {
      "<leader>tg",
      function()
        terms.lazygit:toggle()
      end,
      desc = "lazygit",
    },
    {
      "<leader>td",
      function()
        terms.lazydocker:toggle()
      end,
      desc = "lazydocker",
    },
    {
      "<leader>tp",
      function()
        terms.python:toggle()
      end,
      desc = "ipython",
    },
  },
}

return { toggleterm_table }
