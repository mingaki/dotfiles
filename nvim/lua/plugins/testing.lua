return {
  {
    "nvim-neotest/neotest",
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
