return {
	{
		"petertriho/nvim-scrollbar",
		opts = {
			excluded_filetypes = {
				"aerial",
				"prompt",
				"TelescopePrompt",
				"noice",
				"neo-tree",
				"neo-tree-popup",
			},
		},
	},
	{
		"akinsho/bufferline.nvim",
		opts = {
			options = {
				always_show_bufferline = true,
				offsets = {
					{
						filetype = "neo-tree",
						text = "Neo-tree",
						highlight = "Directory",
						text_align = "left",
						separator = true,
					},
				},
			},
			highlights = {
				offset_separator = {
					fg = {
						highlight = "WinSeparator",
						attribute = "fg",
					},
					bg = {
						highlight = "separator",
						attribute = "bg",
					},
				},
			},
		},
		keys = {
			{ "<leader>bs", "<cmd>BufferLinePick<cr>", desc = "Select a buffer" },
		},
	},
	{
		"folke/noice.nvim",
		opts = function(_, opts)
			vim.list_extend(opts.routes, {
				{ filter = { event = "msg_show", find = "; before #%d+" }, skip = true },
				{ filter = { event = "msg_show", find = "; after #%d+" }, skip = true },
				{ filter = { event = "msg_show", find = "search hit" }, skip = true },
				{
					view = "split",
					filter = { event = "msg_show", min_height = 10 },
				},
			})
		end,
	},
	{
		"nvim-lualine/lualine.nvim",
		opts = function(_, opts)
			-- separators
			opts.options.component_separators = { left = "", right = "" }
			opts.options.section_separators = { left = "", right = "" }
			-- libmodal
			opts.sections.lualine_a = {
				function()
					local mode_name
					if vim.g.libmodalActiveModeName then
						mode_name = vim.g.libmodalActiveModeName
					else
						mode_name = require("lualine.utils.mode").get_mode()
					end
					return mode_name
				end,
			}
			-- table.remove(opts.sections.lualine_c)
		end,
		config = function(_, opts)
			vim.api.nvim_create_autocmd("ModeChanged", {
				callback = function()
					require("lualine").refresh({ scope = "window", place = { "statusline" } })
				end,
			})
			require("lualine").setup(opts)
		end,
	},
	{
		"echasnovski/mini.indentscope",
		event = { "BufReadPre", "BufNewFile" },
		opts = {
			draw = { delay = 0, animation = require("mini.indentscope").gen_animation.none() },
		},
	},
	{
		"stevearc/dressing.nvim",
		opts = {
			input = {
				insert_only = false,
			},
		},
	},
}
