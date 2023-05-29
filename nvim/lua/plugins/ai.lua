local function toggle_copilot()
  local client_list = vim.lsp.get_active_clients({ name = "copilot" })
  local is_enabled = #client_list > 0

  if is_enabled then
    vim.cmd("Copilot disable")
  else
    vim.cmd("Copilot enable")
  end
end

return {
  {
    "zbirenbaum/copilot.lua",
    opts = {
      panel = {
        enabled = true,
        auto_refresh = false,
        keymap = {
          jump_prev = "<M-[>",
          jump_next = "<M-]>",
          accept = "<CR>",
          refresh = "gr",
          open = "<M-CR>",
        },
        layout = {
          position = "right", -- | top | left | right
          ratio = 0.4,
        },
      },
      suggestion = {
        enabled = true,
        auto_trigger = true,
        debounce = 75,
        keymap = {
          accept = false,
          accept_word = false,
          accept_line = false,
          next = "<M-]>",
          prev = "<M-[>",
          dismiss = "<C-]>",
        },
      },
      filetypes = {
        yaml = false,
        markdown = false,
        help = false,
        gitcommit = false,
        gitrebase = false,
        hgcommit = false,
        svn = false,
        cvs = false,
        ["."] = false,
        ["*"] = function()
          if string.match(vim.api.nvim_buf_get_name(0), "leetcode") then
            return false
          else
            return true
          end
        end,
      },
    },
    config = function(_, opts)
      require("copilot").setup(opts)
      vim.keymap.set("i", "<Tab>", function()
        if require("copilot.suggestion").is_visible() then
          require("copilot.suggestion").accept()
        else
          vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes("<Tab>", true, false, true), "n", false)
        end
      end, { desc = "Super Tab" })
    end,
    dependencies = {
      {
        "nvim-lualine/lualine.nvim",
        optional = true,
        event = "VeryLazy",
        opts = function(_, opts)
          local Util = require("lazyvim.util")
          local colors = {
            [""] = Util.fg("Special"),
            ["Normal"] = Util.fg("Special"),
            ["Warning"] = Util.fg("DiagnosticError"),
            ["InProgress"] = Util.fg("DiagnosticWarn"),
          }
          table.insert(opts.sections.lualine_x, 2, {
            function()
              local icon = require("lazyvim.config").icons.kinds.Copilot
              local status = require("copilot.api").status.data
              return icon .. (status.message or "")
            end,
            cond = function()
              local ok, clients = pcall(vim.lsp.get_active_clients, { name = "copilot", bufnr = 0 })
              return ok and #clients > 0
            end,
            color = function()
              local status = require("copilot.api").status.data
              return colors[status.status] or colors[""]
            end,
          })
        end,
      },
    },
    keys = {
      { "<leader>ua", toggle_copilot, desc = "Toggle Copilot" },
    },
  },
  {
    "jackMort/ChatGPT.nvim",
    config = function()
      require("chatgpt").setup({
        edit_with_instructions = {
          diff = false,
          keymaps = {
            use_output_as_input = "<C-u>",
          },
        },
        openai_params = {
          model = "gpt-4",
        },
      })
    end,
    keys = {
      { "<leader>a", "", mode = { "n", "x" }, desc = "ChatGPT+" },
      { "<leader>ac", "<cmd>ChatGPT<CR>", mode = { "n", "x" }, desc = "Chat" },
      { "<leader>aa", "", mode = { "n", "x" }, desc = "Act as+" },
      { "<leader>ae", "<cmd>ChatGPTEditWithInstructions<CR>", mode = { "n", "x" }, desc = "Edit with instruction" },
      { "<leader>ar", "", mode = { "n", "x" }, desc = "Run action+" },
      { "<leader>arg", "<cmd>ChatGPTRun grammar_correction<CR>", mode = { "n", "x" }, desc = "grammar_correction" },
      { "<leader>art", "<cmd>ChatGPTRun translate<CR>", mode = { "n", "x" }, desc = "translate" },
      { "<leader>ark", "<cmd>ChatGPTRun keywords<CR>", mode = { "n", "x" }, desc = "keywords" },
      { "<leader>ard", "<cmd>ChatGPTRun docstring<CR>", mode = { "n", "x" }, desc = "docstring" },
      { "<leader>art", "<cmd>ChatGPTRun add_tests<CR>", mode = { "n", "x" }, desc = "add tests" },
      { "<leader>aro", "<cmd>ChatGPTRun optimize_code<CR>", mode = { "n", "x" }, desc = "optimize code" },
      { "<leader>ars", "<cmd>ChatGPTRun summarize<CR>", mode = { "n", "x" }, desc = "summarize" },
      { "<leader>arf", "<cmd>ChatGPTRun fix_bugs<CR>", mode = { "n", "x" }, desc = "fix_bugs" },
      { "<leader>are", "<cmd>ChatGPTRun explain_codes<CR>", mode = { "n", "x" }, desc = "explain codes" },
      { "<leader>arr", "<cmd>ChatGPTRun roxygen_edit<CR>", mode = { "n", "x" }, desc = "roxygen edit" },
      {
        "<leader>ara",
        "<cmd>ChatGPTRun code_readability_analysis<CR>",
        mode = { "n", "x" },
        desc = "analyze readability",
      },
    },
    dependencies = {
      "MunifTanjim/nui.nvim",
      "nvim-lua/plenary.nvim",
      "nvim-telescope/telescope.nvim",
    },
  },
}
