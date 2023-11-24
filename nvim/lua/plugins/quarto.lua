return {
	{ "stevearc/dressing.nvim", enabled = false },
	{
		"quarto-dev/quarto-nvim",
		dev = false,
		dependencies = {
			{
				"jmbuhr/otter.nvim",
				dev = false,
				dependencies = {
					{ "neovim/nvim-lspconfig" },
				},
				opts = {
					buffers = {
						-- if set to true, the filetype of the otterbuffers will be set.
						-- otherwise only the autocommand of lspconfig that attaches
						-- the language server will be executed without setting the filetype
						set_filetype = true,
					},
				},
			},
		},
		opts = {
			lspFeatures = {
				languages = { "r", "python", "julia", "bash", "lua", "html" },
			},
		},
	},
	{
		"hrsh7th/nvim-cmp",
		dependencies = { "jmbuhr/otter.nvim" },
		opts = function(_, opts)
			---@param opts cmp.ConfigSchema
			local cmp = require("cmp")
			opts.sources = cmp.config.sources(vim.list_extend(opts.sources, { { name = "otter" } }))
		end,
	},
}
