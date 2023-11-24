return {
	{
		"nvim-neotest/neotest",
		dependencies = {
			"nvim-neotest/neotest-plenary",
			"nvim-neotest/neotest-python",
			"nvim-neotest/neotest-vim-test",
		},
		opts = {
			status = { virtual_text = false },
			summary = {
				mappings = {
					expand = { "l", "<CR>", "<2-LeftMouse>" },
				},
			},
			adapters = {
				["neotest-python"] = {
					dap = { justMyCode = false },
					-- is_test_file = function(filepath)
					--   local filename = vim.fn.fnamemodify(filepath, ":t")
					--   return filename:match("^tests?%.?py$")
					--     or filename:match("^test_.+%.py$")
					--     or filename:match("%.test_.+%.py$")
					-- end,
				},
				["neotest-plenary"] = {},
				["neotest-vim-test"] = {
					ignore_file_types = { "python", "vim", "lua" },
				},
			},
		},
	},
}
