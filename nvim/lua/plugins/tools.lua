return {
  {
    "uga-rosa/ccc.nvim",
    keys = {
      { "<leader>uh", "<cmd>CccHighlighterToggle<CR>", desc = "Toggle Highlighter" },
    },
    opts = { highlighter = {
      lsp = true,
    } },
  },
  {
    "kiyoon/jupynium.nvim",
    build = "/Users/claude/.pyenv/versions/py3nvim/bin/pip3 install .",
    opts = {
      auto_download_ipynb = false,
    },
    config = function(_, opts)
      local jupynium = require("jupynium")
      local cells = require("jupynium.cells")
      local textobj = require("jupynium.textobj")

      local function _insert_cell()
        vim.cmd("normal! a# %%")
        vim.cmd("normal! o")
        vim.cmd("startinsert")
      end

      local function insert_cell_above()
        local row = cells.current_cell_separator()
        if row == nil then
          vim.cmd("normal! gg")
        else
          textobj.goto_current_cell_separator()
        end
        vim.cmd("normal! O")
        vim.cmd("normal! O")
        _insert_cell()
      end

      local function insert_cell_below()
        local row = cells.next_cell_separator()
        if row == nil then
          vim.cmd("normal! G")
          vim.cmd("normal! o")
          vim.cmd("normal! o")
        else
          textobj.goto_next_cell_separator()
          vim.cmd("normal! O")
          vim.cmd("normal! O")
        end
        _insert_cell()
      end

      function jupynium.set_default_keymaps(buf_id)
        vim.keymap.set(
          { "n", "x" },
          "<C-CR>",
          "<cmd>JupyniumExecuteSelectedCells<CR>",
          { buffer = buf_id, desc = "Jupynium execute selected cells" }
        )
        vim.keymap.set({ "n", "x", "i" }, "<S-CR>", function()
          vim.cmd("JupyniumExecuteSelectedCells")
          require("jupynium.textobj").goto_next_cell_separator()
        end, { buffer = buf_id, desc = "Jupynium execute selected cells and jump next" })
        vim.keymap.set(
          { "n", "x", "i" },
          "<leader>jl",
          "<cmd>JupyniumClearSelectedCellsOutputs<CR>",
          { buffer = buf_id, desc = "Jupynium clear selected cells" }
        )
        vim.keymap.set(
          { "n" },
          "<leader>jk",
          "<cmd>JupyniumKernelHover<cr>",
          { buffer = buf_id, desc = "Jupynium hover (inspect a variable)" }
        )
        vim.keymap.set({ "n" }, "<leader>ji", "a# %%<CR>", { buffer = buf_id, desc = "Insert a cell separator" })
        vim.keymap.set({ "n" }, "<leader>jO", function()
          insert_cell_above()
        end, { buffer = buf_id, desc = "Insert a cell above" })
        vim.keymap.set({ "n" }, "<leader>jo", function()
          insert_cell_below()
        end, { buffer = buf_id, desc = "Insert a cell below" })
      end

      jupynium.setup(opts)

      local function connect_repl(args)
        local hostname = args.args
        local buf = vim.api.nvim_get_current_buf()
        local cmd = Jupynium_get_kernel_connect_shcmd(buf, hostname)

        local repl = require("toggleterm.terminal").Terminal:new({
          cmd = cmd,
          hidden = true,
          direction = "vertical",
          count = 42,
        })
        repl:toggle()
        vim.keymap.set({ "n" }, "<leader>tj", function()
          repl:toggle()
        end, { noremap = true, silent = true, desc = "Jupynium REPL" })
      end
      vim.api.nvim_create_user_command("JupyniumToggleREPL", connect_repl, { nargs = "?" })
    end,
  },
  {
    "pwntester/octo.nvim",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-telescope/telescope.nvim",
      "nvim-tree/nvim-web-devicons",
    },
    opts = {},
  },
}
