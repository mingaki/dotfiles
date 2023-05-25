return {
  {
    "nvim-neotest/neotest",
    dependencies = {
      "nvim-neotest/neotest-plenary",
      "nvim-neotest/neotest-python",
      "nvim-neotest/neotest-vim-test",
    },
    opts = {
      adapters = {
        ["neotest-python"] = {
          dap = { justMyCode = false },
        },
        ["neotest-plenary"] = {},
        ["neotest-vim-test"] = {
          ignore_file_types = { "python", "vim", "lua" },
        },
      },
    },
  },
}
