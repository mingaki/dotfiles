Daynight_mode = ""
local filepath = "~/.config/state.yml"

function Get_system_mode()
    local mode
    local handle = io.popen("yq '.mode' < " .. filepath)
    if handle then
        local output = handle:read("*a")
        mode = output:gsub("[\n%s]+$", "")
        handle:close()
    end
    return mode
end

function Get_mode_theme(mode)
    local mode_themes = { day = "zenbones", night = "seoulbones" }
    local theme = mode_themes[mode]
    if not theme then
        theme = "dayfox"
    end
    return theme
end

function Set_background(mode)
    if mode == "day" then
        vim.cmd("set background=light")
    else
        vim.cmd("set background=dark")
    end
end

function Set_mode(mode)
    local theme = Get_mode_theme(mode)
    vim.cmd("colorscheme " .. theme)
    Set_background(mode)
    Daynight_mode = mode
end

function Toggle_mode()
    if Daynight_mode == "day" then
        Set_mode("night")
    else
        Set_mode("day")
    end
    os.execute("sketchybar --trigger sync_daynight")
end

function Sync_mode()
    local sys_mode = Get_system_mode()
    if sys_mode == Daynight_mode then
        return
    end
    Set_mode(sys_mode)
end

return {
    {
        "LazyVim/LazyVim",
        opts = {
            colorscheme = function()
                Sync_mode()
            end,
        },
    },
    {
        "EdenEast/nightfox.nvim",
        lazy = true,
        opts = {
            options = {
                styles = {
                    keywords = "italic,bold",
                },
            },
            groups = {
                all = {
                    NeoTreeNormal = { bg = "bg1" },
                    ["@keyword.function"] = {
                        style = "italic,bold",
                    },
                },
                dayfox = {
                    LspReferenceText = { bg = "#cfd1c9" },
                },
            },
        },
    },
    {
        "folke/tokyonight.nvim",
        opts = {
            styles = {
                keywords = { italic = true, bold = true },
            },
            on_highlights = function(hl, c)
                hl["@keyword.function"].style = {
                    bold = true,
                    italic = true,
                }
            end,
        },
    },
    {
        "catppuccin/nvim",
        name = "catppuccin",
        enabled = false,
        opts = {
            flavour = "frappe",
            background = { -- :h background
                light = "frappe",
                dark = "frappe",
            },
            styles = {
                keywords = { "italic", "bold" },
            },
            custom_highlights = function(colors)
                return {
                    ["@keyword.function"] = { style = { "italic", "bold" } },
                }
            end,
        },
    },
    {
        "mcchrish/zenbones.nvim",
        dependencies = { "rktjmp/lush.nvim" },
        config = function()
            vim.api.nvim_create_autocmd("ColorScheme", {
                pattern = { "seoulbones", "zenbones" },
                callback = function()
                    if vim.o.background == "light" then
                        vim.api.nvim_set_hl(0, "NeoTreeGitConflict", { bold = true, italic = true, fg = "#be6a84" })
                        vim.api.nvim_set_hl(0, "NeoTreeGitUntracked", { italic = true, fg = "#be6a84" })
                        vim.api.nvim_set_hl(0, "NeoTreeDirectoryIcon", { fg = "#8898b5" })
                        vim.api.nvim_set_hl(0, "NotifyINFOIcon", { fg = "#749169" })
                        vim.api.nvim_set_hl(0, "NotifyINFOTitle", { fg = "#749169" })
                    end
                    local statement_fg = vim.api.nvim_get_hl(0, { name = "Statement" }).fg
                    vim.api.nvim_set_hl(0, "@keyword.function", { bold = true, italic = true, fg = statement_fg })
                    vim.api.nvim_set_hl(0, "@keyword", { bold = true, italic = true, fg = statement_fg })
                    vim.api.nvim_set_hl(0, "@string", { link = "String" })

                    -- neotest
                    vim.api.nvim_set_hl(0, "NeotestFailedxxx", { link = "Error" })
                    vim.api.nvim_set_hl(0, "NeotestDir", { link = "NeoTreeDirectoryText" })
                    vim.api.nvim_set_hl(0, "NeotestFile", { link = "NeotestDir" })
                    vim.api.nvim_set_hl(0, "NeotestNamespace", { link = "NeotestDir" })
                    vim.api.nvim_set_hl(0, "NeotestAdapterName", { bold = true, italic = true })
                    vim.api.nvim_set_hl(0, "NeotestRunning", { link = "WarningMsg" })
                    vim.api.nvim_set_hl(0, "NeotestPassed", { link = "MoreMsg" })
                    vim.api.nvim_set_hl(0, "NeotestFailed", { link = "Error" })
                    vim.api.nvim_set_hl(0, "NeotestMarked", { link = "GitSignsAdd" })
                    vim.api.nvim_set_hl(0, "NeotestTarget", { link = "Statement" })
                    vim.api.nvim_set_hl(0, "NeotestSkipped", { link = "NeoTreeDotfile" })
                    vim.api.nvim_set_hl(0, "NeotestWinselect", { link = "NeoTreeDotfile" })
                end,
            })
        end,
    },
}
