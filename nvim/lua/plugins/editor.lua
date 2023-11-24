return {
	{
		"nvim-neo-tree/neo-tree.nvim",
		opts = {
			renderers = {
				message = {
					{ "indent", with_markers = true },
					{ "name", highlight = "NeoTreeMessage" },
				},
			},
			filesystem = {
				filtered_items = {
					hide_dotfiles = false,
					always_show = { ".env" },
					never_show = { ".git", ".venv", "node_modules", ".DS_Store" },
					never_show_by_pattern = { "*cache" },
				},
			},
			window = {
				mappings = {
					["l"] = {
						"open",
						nowait = false, -- disable `nowait` if you have existing combos starting with this char that you want to use
					},
					["e"] = "focus_preview",
				},
			},
		},
	},
	{
		"nvim-telescope/telescope.nvim",
		dependencies = {
			"nvim-telescope/telescope-fzf-native.nvim",
			build = "make",
			config = function()
				require("telescope").load_extension("fzf")
			end,
		},
		opts = {
			pickers = {
				find_files = { hidden = true },
				live_grep = {
					additional_args = function(opts)
						return { "--hidden" }
					end,
				},
			},
			defaults = {
				file_ignore_patterns = { ".git/", "node_modules", ".venv" },
				mappings = {
					i = {
						["<C-o>"] = function(prompt_bufnr)
							require("telescope.actions").select_default(prompt_bufnr)
							require("telescope.builtin").resume()
						end,
						["<c-x>"] = function(prompt_bufnr)
							local actions = require("telescope.actions")
							actions.delete_buffer(prompt_bufnr)
							actions.move_to_top(prompt_bufnr)
						end,
						["<c-s>"] = require("telescope.actions").select_horizontal,
					},
				},
			},
		},
		keys = {
			{ "<leader>sC", "<cmd>Telescope command_history<cr>", desc = "Command History" },
			{ "<leader>sc", "<cmd>Telescope commands<cr>", desc = "Commands" },
		},
	},
	{
		"folke/trouble.nvim",
		keys = {
			{ "<leader>xl", "<cmd>TroubleToggle loclist<cr>", desc = "Location List (Trouble)" },
			{ "<leader>xq", "<cmd>TroubleToggle quickfix<cr>", desc = "Quickfix List (Trouble)" },
		},
	},
	{
		"Iron-E/nvim-bufmode",
		cmd = "BufmodeEnter",
		dependencies = {
			"Iron-E/nvim-libmodal",
			"akinsho/bufferline.nvim",
		},
		keys = { { "<leader>bm", "<cmd>BufmodeEnter<cr>", desc = "Enter buffer mode", mode = "n" } },
		opts = { bufferline = true, keymaps = { p = "BufferLineTogglePin", s = "BufferLinePick" } },
	},
}
