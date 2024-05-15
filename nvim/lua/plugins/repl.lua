return {
    {
        "vhyrro/luarocks.nvim",
        priority = 1001, -- this plugin needs to run before anything else
        opts = {
            rocks = { "magick" },
        },
    },
    {
        -- see the image.nvim readme for more information about configuring this plugin
        "3rd/image.nvim",
        version = "*",
        dependencies = { "luarocks.nvim" },
        opts = {
            backend = "kitty", -- whatever backend you would like to use
            -- max_width = 100,
            -- max_height = 12,
            tmux_show_only_in_active_window = true,
            max_height_window_percentage = math.huge,
            max_width_window_percentage = math.huge,
            window_overlap_clear_enabled = true, -- toggles images when windows are overlapped
            window_overlap_clear_ft_ignore = { "cmp_menu", "cmp_docs", "" },
        },
    },
    {
        "benlubas/molten-nvim",
        version = "*", -- use version <2.0.0 to avoid breaking changes
        dependencies = { "3rd/image.nvim" },
        build = ":UpdateRemotePlugins",
        init = function()
            vim.g.molten_auto_open_output = false
            vim.g.molten_image_provider = "image.nvim"
            vim.g.molten_wrap_output = false
            vim.g.molten_virt_text_output = true
            vim.g.molten_virt_text_max_lines = 50
            vim.g.molten_virt_lines_off_by_1 = true
            vim.g.molten_enter_output_behavior = "open_and_enter"

            vim.cmd([[hi! link MoltenCell NONE]])
            vim.cmd([[hi! link MoltenVirtualText NONE]])
            vim.api.nvim_create_autocmd("User", {
                pattern = "MoltenInitPost",
                callback = function()
                    -- if we're in a python file, change the configuration a little
                    if vim.bo.filetype == "python" then
                        vim.fn.MoltenUpdateOption("molten_virt_lines_off_by_1", false)
                        vim.fn.MoltenUpdateOption("molten_virt_text_output", false)
                    end
                end,
            })

            -- change the configuration when editing a python file
            vim.api.nvim_create_autocmd("BufEnter", {
                pattern = "*.py",
                callback = function(e)
                    if string.match(e.file, ".otter.") then
                        return
                    end
                    if require("molten.status").initialized() == "Molten" then
                        vim.fn.MoltenUpdateOption("molten_virt_lines_off_by_1", false)
                        vim.fn.MoltenUpdateOption("molten_virt_text_output", false)
                    end
                end,
            })

            -- Undo those config changes when we go back to a markdown or quarto file
            vim.api.nvim_create_autocmd("BufEnter", {
                pattern = { "*.qmd", "*.md", "*.ipynb" },
                callback = function()
                    if require("molten.status").initialized() == "Molten" then
                        vim.fn.MoltenUpdateOption("molten_virt_lines_off_by_1", true)
                        vim.fn.MoltenUpdateOption("molten_virt_text_output", true)
                    end
                end,
            })
        end,
        keys = {
            { "<leader>m", "", mode = { "n" }, desc = "+Molten" },
            { "<leader>mi", "<cmd>MoltenInit<cr>", mode = { "n" }, desc = "initialize the plugin" },
            { "<leader>mr", "<cmd>MoltenRestart<cr>", mode = { "n" }, desc = "restart kernel" },
            { "<leader>mo", "<cmd>MoltenEvaluateOperator<cr>", mode = { "n" }, desc = "run operator selection" },
            { "<leader>ml", "<cmd>MoltenEvaluateLine<cr>", mode = { "n" }, desc = "evaluate line" },
            { "<leader>mc", "<cmd>MoltenReevaluateCell<cr>", mode = { "n" }, desc = "re-evaluate cell" },
            {
                "<leader>mr",
                ":<C-u>MoltenEvaluateVisual<cr>gv",
                mode = { "v" },
                desc = "evaluate visual selection",
            },
            { "<leader>md", "<cmd>MoltenDelete<cr>", mode = { "n" }, desc = "delete cell" },
            { "<leader>mh", "<cmd>MoltenHideOutput<cr>", mode = { "n" }, desc = "hide output" },
            { "<leader>ms", "<cmd>noautocmd MoltenEnterOutput<cr>", mode = { "n" }, desc = "show/enter output" },
            { "<leader>mx", "<cmd>MoltenOpenInBrowser<cr>", mode = { "n" }, desc = "open in browser" },
            { "<leader>m]", "<cmd>MoltenNext<cr>", mode = { "n" }, desc = "next cell" },
            { "<leader>m[", "<cmd>MoltenPrev<cr>", mode = { "n" }, desc = "prev cell" },
        },
    },
    {
        "quarto-dev/quarto-nvim",
        dev = false,
        dependencies = {
            {
                "jmbuhr/otter.nvim",
                opts = {
                    handle_leading_whitespace = true,
                    lsp = {
                        hover = { border = "none" },
                    },
                },
                dev = false,
            },
        },
        ft = { "quarto", "markdown", "norg" },
        config = function()
            require("quarto").setup({
                debug = true,
                lspFeatures = {
                    languages = { "r", "python", "julia", "bash", "lua", "html" },
                    chunks = "all",
                    diagnostics = {
                        enabled = true,
                        triggers = { "BufWritePost" },
                    },
                    completion = {
                        enabled = true,
                    },
                },
                codeRunner = {
                    enabled = true,
                    default_method = "molten",
                    ft_runners = { python = "molten" },
                },
            })
        end,
        init = function()
            vim.api.nvim_create_autocmd("BufEnter", {
                pattern = { "*.qmd", "*.md", "*.ipynb" },
                callback = function()
                    -- otter lsp
                    vim.keymap.set("n", "K", require("otter").ask_hover, { buffer = true })
                    vim.keymap.set("n", "gd", require("otter").ask_definition, { buffer = true })
                    vim.keymap.set("n", "gr", require("otter").ask_references, { buffer = true })
                    vim.keymap.set("n", "<leader>cf", require("otter").ask_format, { buffer = true })
                    vim.keymap.set("n", "<leader>cr", require("otter").ask_rename, { buffer = true })

                    -- cell operations
                    local runner = require("quarto.runner")
                    vim.keymap.set("n", "<leader>rc", runner.run_cell, { desc = "run cell", silent = true })
                    vim.keymap.set("n", "<leader>ra", runner.run_above, { desc = "run cell and above", silent = true })
                    vim.keymap.set("n", "<leader>rA", runner.run_all, { desc = "run all cells", silent = true })
                    vim.keymap.set("n", "<leader>rl", runner.run_line, { desc = "run line", silent = true })
                    vim.keymap.set("v", "<leader>r", runner.run_range, { desc = "run visual range", silent = true })
                    vim.keymap.set("n", "<leader>rZ", function()
                        runner.run_all(true)
                    end, { desc = "run all cells of all languages", silent = true })
                    vim.keymap.set("n", "<leader>rs", function()
                        vim.cmd("normal mz[bkyy`zp")
                        vim.cmd("delm z")
                        local cursor_line = vim.api.nvim_win_get_cursor(0)[1]
                        vim.api.nvim_buf_set_lines(0, cursor_line - 1, cursor_line - 1, false, { "```" })
                        vim.cmd("normal O")
                    end, { desc = "split cell", silent = true })
                end,
            })
        end,
        keys = {
            { "<leader>r", "", mode = { "n" }, desc = "quarto run+" },
        },
    },
    {
        "GCBallesteros/jupytext.nvim",
        opts = {
            style = "markdown",
            output_extension = "md",
            force_ft = "markdown",
        },
    },
    {
        "nvim-treesitter/nvim-treesitter",
        opts = {
            textobjects = {
                move = {
                    enable = true,
                    set_jumps = false,
                    goto_next_start = {
                        ["]b"] = { query = "@code_cell.inner", desc = "next code block" },
                    },
                    goto_previous_start = {
                        ["[b"] = { query = "@code_cell.inner", desc = "previous code block" },
                    },
                },
                select = {
                    enable = true,
                    lookahead = true,
                    keymaps = {
                        ["ib"] = { query = "@code_cell.inner", desc = "in block" },
                        ["ab"] = { query = "@code_cell.outer", desc = "around block" },
                    },
                },
            },
        },
    },
}
