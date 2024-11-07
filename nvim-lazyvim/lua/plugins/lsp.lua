return {
    {
        "neovim/nvim-lspconfig",
        opts = {
            diagnostics = {
                virtual_text = false,
            },
        },
        init = function()
            local keys = require("lazyvim.plugins.lsp.keymaps").get()
            keys[#keys + 1] = { "gl", vim.diagnostic.open_float, desc = "Diagnostic" }
        end,
    },
    {
        "rmagatti/goto-preview",
        config = function()
            require("goto-preview").setup({
                post_open_hook = function(buff, win)
                    vim.keymap.set("n", "q", function()
                        if vim.api.nvim_win_is_valid(win) then
                            vim.api.nvim_win_close(win, true)
                        end
                    end, { buffer = buff })
                end,
            })
        end,
        keys = {
            { "gp", "", mode = { "n" }, desc = "Preview+" },
            {
                "gpd",
                "<cmd>lua require('goto-preview').goto_preview_definition()<cr>",
                desc = "Goto Preview Definition",
            },
            {
                "gpD",
                "<cmd>lua require('goto-preview').goto_preview_declaration()<cr>",
                desc = "Goto Preview Declaration",
            },
            {
                "gpi",
                "<cmd>lua require('goto-preview').goto_preview_implementation()<cr>",
                desc = "Goto Preview Implementation",
            },
            {
                "gpt",
                "<cmd>lua require('goto-preview').goto_preview_type_definition()<cr>",
                desc = "Goto Preview Type Definition",
            },
            {
                "gpr",
                "<cmd>lua require('goto-preview').goto_preview_references()<cr>",
                desc = "Goto Preview References",
            },
        },
    },
}
