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
