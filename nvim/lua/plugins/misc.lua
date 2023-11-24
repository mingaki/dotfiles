return {
	{
		"folke/zen-mode.nvim",
		cmd = "ZenMode",
		opts = {
			plugins = {
				-- tmux = true,
				kitty = { enabled = true, font = "+1" },
			},
		},
		keys = { { "<leader>z", "<cmd>ZenMode<cr>", desc = "Zen Mode" } },
	},
	{
		"uga-rosa/ccc.nvim",
		keys = {
			{ "<leader>uh", "<cmd>CccHighlighterToggle<CR>", desc = "Toggle Highlighter" },
		},
		opts = { highlighter = {
			lsp = true,
		} },
	},
}
