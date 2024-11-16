return {
  {
    "nvim-lualine/lualine.nvim",
    event = "VeryLazy",
    opts = {
      options = {
        component_separators = { left = "", right = "" },
        section_separators = { left = "", right = "" },
      },
      sections = {
        lualine_c = { { "filename", path = 3 } },
      },
    },
  },
  {
    "Bekaboo/dropbar.nvim",
    event = { "BufReadPre", "BufNewFile" },
    dependencies = {
      "nvim-telescope/telescope-fzf-native.nvim",
      build = "make",
    },
    opts = {
      -- disable file path
      bar = {
        sources = function(buf, _)
          local sources = require("dropbar.sources")
          local utils = require("dropbar.utils")

          local filename = {
            get_symbols = function(buff, win, cursor)
              local symbols = sources.path.get_symbols(buff, win, cursor)
              return { symbols[#symbols] }
            end,
          }

          if vim.bo[buf].ft == "markdown" then
            return { filename, sources.markdown }
          end
          if vim.bo[buf].buftype == "terminal" then
            return { filename, sources.terminal }
          end
          return { filename, utils.source.fallback({ sources.lsp, sources.treesitter }) }
        end,
      },
    },
    config = function(_, opts)
      vim.api.nvim_set_hl(0, "WinBar", { link = "NavicText" })
      require("dropbar").setup(opts)
    end,
    keys = {
      {
        "<leader>cp",
        function()
          require("dropbar.api").pick()
        end,
        desc = "Pick dropbar",
      },
    },
  },
  "nvim-tree/nvim-web-devicons",
  {
    "echasnovski/mini.indentscope",
    event = { "BufReadPre", "BufNewFile" },
    opts = {
      symbol = "▏",
      options = { try_as_border = true },
      draw = {
        delay = 0,
      },
    },
    config = function(_, opts)
      opts.draw.animation = require("mini.indentscope").gen_animation.none()
      require("mini.indentscope").setup(opts)
    end,
    init = function()
      vim.api.nvim_create_autocmd("FileType", {
        pattern = {
          "alpha",
          "dashboard",
          "fzf",
          "help",
          "lazy",
          "lazyterm",
          "mason",
          "neo-tree",
          "notify",
          "toggleterm",
          "Trouble",
          "trouble",
        },
        callback = function()
          vim.b.miniindentscope_disable = true
        end,
      })
    end,
  },
  {
    "nvimdev/dashboard-nvim",
    lazy = false, -- As https://github.com/nvimdev/dashboard-nvim/pull/450, dashboard-nvim shouldn't be lazy-loaded to properly handle stdin.
    opts = function()
      local logo = [[
      ██╗  ██╗██╗        ██████╗██╗      █████╗ ██╗   ██╗██████╗ ███████╗██╗
      ██║  ██║██║       ██╔════╝██║     ██╔══██╗██║   ██║██╔══██╗██╔════╝██║
      ███████║██║       ██║     ██║     ███████║██║   ██║██║  ██║█████╗  ██║
      ██╔══██║██║       ██║     ██║     ██╔══██║██║   ██║██║  ██║██╔══╝  ╚═╝
      ██║  ██║██║▄█╗    ╚██████╗███████╗██║  ██║╚██████╔╝██████╔╝███████╗██╗
      ╚═╝  ╚═╝╚═╝╚═╝     ╚═════╝╚══════╝╚═╝  ╚═╝ ╚═════╝ ╚═════╝ ╚══════╝╚═╝
  ]]

      logo = string.rep("\n", 8) .. logo .. "\n\n"

      local opts = {
        theme = "doom",
        hide = {
          -- this is taken care of by lualine
          -- enabling this messes up the actual laststatus setting after loading a file
          statusline = true,
        },
        config = {
          header = vim.split(logo, "\n"),
      -- stylua: ignore
      center = {
        { action = 'lua require("fzf-lua").files()',                 desc = " Find File",       icon = " ", key = "f" },
        { action = "ene | startinsert",                              desc = " New File",        icon = " ", key = "n" },
        { action = 'lua require("fzf-lua").oldfiles()',              desc = " Recent Files",    icon = " ", key = "r" },
        { action = 'lua require("fzf-lua").live_grep()',             desc = " Find Text",       icon = " ", key = "g" },
        { action = 'lua require("persistence").load()',              desc = " Restore Session", icon = " ", key = "s" },
        { action = "Lazy",                                           desc = " Lazy",            icon = "󰒲 ", key = "l" },
        { action = function() vim.api.nvim_input("<cmd>qa<cr>") end, desc = " Quit",            icon = " ", key = "q" },
      },
          footer = function()
            local stats = require("lazy").stats()
            local ms = (math.floor(stats.startuptime * 100 + 0.5) / 100)
            return { "⚡ Neovim loaded " .. stats.loaded .. "/" .. stats.count .. " plugins in " .. ms .. "ms" }
          end,
        },
      }

      for _, button in ipairs(opts.config.center) do
        button.desc = button.desc .. string.rep(" ", 43 - #button.desc)
        button.key_format = "  %s"
      end

      -- open dashboard after closing lazy
      if vim.o.filetype == "lazy" then
        vim.api.nvim_create_autocmd("WinClosed", {
          pattern = tostring(vim.api.nvim_get_current_win()),
          once = true,
          callback = function()
            vim.schedule(function()
              vim.api.nvim_exec_autocmds("UIEnter", { group = "dashboard" })
            end)
          end,
        })
      end

      return opts
    end,
  },
}
