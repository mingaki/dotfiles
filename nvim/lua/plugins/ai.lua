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
    cmd = "Copilot",
    build = ":Copilot auth",
    opts = {
      suggestion = { enabled = false },
      panel = { enabled = false },
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
    keys = {
      { "<leader>ua", toggle_copilot, desc = "Toggle Copilot" },
    },
  },
  {
    "jackMort/ChatGPT.nvim",
    event = "VeryLazy",
    opts = {
      openai_params = {
        model = "gpt-4",
      },
    },
    dependencies = {
      "MunifTanjim/nui.nvim",
      "nvim-lua/plenary.nvim",
      "nvim-telescope/telescope.nvim",
    },
  },
}
