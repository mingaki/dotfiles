return {
  {
    "nvim-neotest/neotest",
    event = "VeryLazy",
    dependencies = {
      "nvim-neotest/neotest-python",
      "nvim-neotest/neotest-plenary",
      "nvim-neotest/neotest-vim-test",
    },
    config = function()
      require("neotest").setup({
        adapters = {
          require("neotest-python")({
            dap = { justMyCode = false },
          }),
          require("neotest-plenary"),
          require("neotest-vim-test")({
            ignore_file_types = { "python", "vim", "lua" },
          }),
        },
        quickfix = {
          open = function()
            vim.cmd("Trouble quickfix")
          end,
        },
      })

      -- keymap
      local wk = require("which-key")
      wk.register({
        t = {
          name = "+test", -- optional group name
          s = {
            function()
              require("neotest").summary.toggle()
            end,
            "Toggle neotest summary",
          },
        },
      }, { prefix = "<leader>" })
    end,
  },
}
