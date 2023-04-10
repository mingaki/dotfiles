return {
  {
    "akinsho/toggleterm.nvim",
    version = "*",
    config = function()
      require("toggleterm").setup({
        size = function(term)
          if term.direction == "horizontal" then
            return vim.o.lines * 0.4
          elseif term.direction == "vertical" then
            return vim.o.columns * 0.4
          end
        end,
        open_mapping = [[<c-\>]],
        shade_terminals = false,
        persist_size = true,
        persist_mode = true,
        insert_mappings = true,
        start_in_insert = true,
        close_on_exit = true,
        direction = "horizontal",
        float_opts = {
          border = "curved",
        },
      })

      -- autocmds
      function _G.set_terminal_keymaps()
        local opts = { noremap = true }
        vim.api.nvim_buf_set_keymap(0, "t", "<C-h>", [[<C-\><C-n><C-W>h]], opts)
        vim.api.nvim_buf_set_keymap(0, "t", "<C-j>", [[<C-\><C-n><C-W>j]], opts)
        vim.api.nvim_buf_set_keymap(0, "t", "<C-k>", [[<C-\><C-n><C-W>k]], opts)
        vim.api.nvim_buf_set_keymap(0, "t", "<C-l>", [[<C-\><C-n><C-W>l]], opts)
      end

      vim.cmd("autocmd! TermOpen term://* lua set_terminal_keymaps()")

      vim.cmd("autocmd! BufEnter term://* startinsert")

      -- lazygit
      local Terminal = require("toggleterm.terminal").Terminal
      local lazygit = Terminal:new({
        cmd = "lazygit",
        hidden = true,
        direction = "float",
        on_open = function(term)
          vim.api.nvim_buf_set_keymap(term.bufnr, "t", "q", "<cmd>close<CR>", { noremap = true, silent = true })
        end,
        count = 5,
      })

      vim.keymap.set("n", "<leader>gg", function()
        lazygit:toggle()
      end, { noremap = true, silent = true })
      vim.keymap.set("n", "<leader>tg", function()
        lazygit:toggle()
      end, { noremap = true, silent = true })

      -- lazydocker
      local lazydocker = Terminal:new({
        cmd = "lazydocker",
        hidden = true,
        direction = "float",
        on_open = function(term)
          vim.api.nvim_buf_set_keymap(term.bufnr, "t", "q", "<cmd>close<CR>", { noremap = true, silent = true })
        end,
        count = 6,
      })

      vim.keymap.set("n", "<leader>td", function()
        lazydocker:toggle()
      end, { noremap = true, silent = true })

      -- python
      local python = Terminal:new({
        cmd = "ipython --matplotlib",
        hidden = true,
        direction = "vertical",
        count = 7,
      })
      vim.keymap.set("n", "<leader>tp", function()
        python:toggle()
      end, { noremap = true, silent = true })
    end,
    keys = {
      {
        "<C-\\>",
        desc = "Toggle last terminal",
      },
      {
        "<leader>t",
        desc = "Toggleterm+",
      },
      {
        "<leader>gg",
        desc = "lazygit",
      },
      {
        "<leader>tg",
        desc = "lazygit",
      },
      {
        "<leader>td",
        desc = "lazydocker",
      },
      {
        "<leader>tp",
        desc = "ipython",
      },
    },
  },
}
