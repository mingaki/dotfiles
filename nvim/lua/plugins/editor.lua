return {
    ---@type LazySpec
    {
        "mikavilpas/yazi.nvim",
        dependencies = {
            "nvim-lua/plenary.nvim",
        },
        keys = {
            {
                "<leader>y",
                function()
                    require("yazi").yazi()
                end,
                desc = "Yazi (Root Dir)",
            },
            {
                -- Open in the current working directory
                "<leader>Y",
                function()
                    require("yazi").yazi(nil, vim.fn.getcwd())
                end,
                desc = "Yazi (cwd)",
            },
        },
    },
    {
        "stevearc/oil.nvim",
        ---@module 'oil'
        ---@type oil.SetupOpts
        opts = {
            default_file_explorer = true,
        },
        -- Optional dependencies
        dependencies = { { "echasnovski/mini.icons", opts = {} } },
        lazy = false,
        keys = {
            {
                "-",
                "<cmd>Oil<cr>",
                mode = "n",
                desc = "Open Parent Directory in Oil",
            },
        },
    },
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
                hijack_netrw_behavior = "disabled",
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
        version = "*",
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
                buffers = {
                    mappings = {
                        i = {
                            ["<c-x>"] = function(prompt_bufnr)
                                local actions = require("telescope.actions")
                                actions.delete_buffer(prompt_bufnr)
                                -- actions.move_to_top(prompt_bufnr)
                            end,
                        },
                    },
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
        "ibhagwan/fzf-lua",
        opts = {
            winopts = {
                backdrop = 100,
            },
        },
    },
    {
        "folke/trouble.nvim",
        opts = {
            win = { size = 0.25 },
        },
        keys = {

            {
                "<leader>cs",
                "<cmd>Trouble symbols toggle focus=true<cr>",
                desc = "Symbols (Trouble)",
            },
            {
                "<leader>cS",
                "<cmd>Trouble lsp toggle focus=true<cr>",
                desc = "LSP references/definitions/... (Trouble)",
            },
        },
    },
    {
        "Iron-E/nvim-bufmode",
        enabled = false,
        cmd = "BufmodeEnter",
        dependencies = {
            "Iron-E/nvim-libmodal",
            "akinsho/bufferline.nvim",
        },
        keys = { { "<leader>bm", "<cmd>BufmodeEnter<cr>", desc = "Enter buffer mode", mode = "n" } },
        opts = { bufferline = true, keymaps = { p = "BufferLineTogglePin", s = "BufferLinePick" } },
    },
}
