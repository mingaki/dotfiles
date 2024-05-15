return {
    {
        "danymat/neogen",
        keys = {
            {
                "<leader>cG",
                function()
                    local neogen = require("neogen")
                    local filetype = vim.bo.filetype
                    local convention = vim.fn.input("Covention for " .. filetype .. ": ")
                    if neogen.conventions ~= nil then
                        neogen.conventions[filetype] = convention
                    else
                        neogen.conventions = { [filetype] = convention }
                    end
                end,
                desc = "Neogen set convention",
            },
            {
                "<leader>cg",
                function()
                    local neogen = require("neogen")
                    if neogen.conventions ~= nil then
                        neogen.generate({ annotation_convention = neogen.conventions })
                    else
                        neogen.generate({})
                    end
                end,
                desc = "Neogen Comment",
            },
        },
        opts = { snippet_engine = "luasnip" },
    },
    {
        "windwp/nvim-autopairs",
        event = "VeryLazy",
        vscode = true,
        config = function()
            require("nvim-autopairs").setup({})
        end,
    },
    {
        "kylechui/nvim-surround",
        version = "*", -- Use for stability; omit to use `main` branch for the latest features
        event = "VeryLazy",
        vscode = true,
        config = function()
            require("nvim-surround").setup({
                keymaps = {
                    visual = "z",
                },
            })
        end,
    },
    {
        "L3MON4D3/LuaSnip",
        keys = function()
            return {}
        end,
    },
    {
        "hrsh7th/nvim-cmp",
        opts = function(_, opts)
            -- add jupynium source
            local cmp = require("cmp")
            opts.sources = cmp.config.sources(vim.list_extend({ { name = "otter" } }, opts.sources))
            opts.completion.completeopt = opts.completion.completeopt .. ",noselect"
            opts.preselect = cmp.PreselectMode.None
            -- SuperTab
            local has_words_before = function()
                unpack = unpack or table.unpack
                local line, col = unpack(vim.api.nvim_win_get_cursor(0))
                return col ~= 0
                    and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match("%s") == nil
            end

            local luasnip = require("luasnip")

            opts.mapping = vim.tbl_extend("force", opts.mapping, {
                ["<Tab>"] = cmp.mapping(function(fallback)
                    -- You could replace the expand_or_jumpable() calls with expand_or_locally_jumpable()
                    -- this way you will only jump inside the snippet region
                    if luasnip.expand_or_jumpable() then
                        luasnip.expand_or_jump()
                    elseif cmp.visible() then
                        cmp.select_next_item()
                    elseif has_words_before() then
                        cmp.complete()
                    else
                        fallback()
                    end
                end, { "i", "s" }),
                ["<S-Tab>"] = cmp.mapping(function(fallback)
                    if cmp.visible() then
                        cmp.select_prev_item()
                    elseif luasnip.jumpable(-1) then
                        luasnip.jump(-1)
                    else
                        fallback()
                    end
                end, { "i", "s" }),
            })
        end,
        keys = {
            {
                "<C-c>",
                function()
                    require("cmp").close()
                end,
                mode = { "i" },
                desc = "Close cmp menu",
            },
        },
    },
    {
        "L3MON4D3/LuaSnip",
        config = function()
            local ls = require("luasnip")
            ls.setup({
                link_children = true,
                link_roots = false,
                keep_roots = false,
                update_events = { "TextChanged", "TextChangedI" },
            })

            vim.cmd.runtime({ args = { "lua/snippets/*.lua" }, bang = true }) -- load custom snippets
        end,
    },
}
