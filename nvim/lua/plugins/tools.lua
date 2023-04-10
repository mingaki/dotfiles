return {
  {
    "uga-rosa/ccc.nvim",
    keys = {
      { "<leader>uh", "<cmd>CccHighlighterToggle<CR>", desc = "Toggle Highlighter" },
    },
    event = "VeryLazy",
    opts = { highlighter = {
      auto_enable = true,
      lsp = true,
    } },
  },
  {
    "sindrets/diffview.nvim",
    cmd = { "DiffviewOpen", "DiffviewClose", "DiffviewToggleFiles", "DiffviewFocusFiles" },
    config = true,
    keys = { { "<leader>gd", "<cmd>DiffviewOpen<cr>", desc = "DiffView" } },
  },
  {
    "stevearc/overseer.nvim",
    cmd = { "OverseerRun", "OverseerToggle" },
    keys = {
      { "<leader>o", desc = "Run tasks (Overseer)+" },
      { "<leader>ot", "<cmd>OverseerToggle<cr>", desc = "Overseer: toggle task list" },
      { "<leader>or", "<cmd>OverseerRun<cr>", desc = "Overseer: run task" },
    },
    opts = {
      strategy = "toggleterm",
    },
    config = true,
  },
  {
    "jpalardy/vim-slime",
    config = function()
      vim.g.slime_target = "neovim"
    end,
  },
  {
    "hanschen/vim-ipython-cell",
    dependencies = { "jpalardy/vim-slime" },
    keys = {
      { "<C-c>r", "<cmd>IPythonCellRun<CR>", desc = "Run script" },
      { "<C-c>R", "<cmd>IPythonCellRunTime<CR>", desc = "Run script and time execution" },
      { "<C-CR>", "<cmd>IPythonCellExecuteCell<CR>", desc = "Execute cell" },
      { "<S-CR>", "<cmd>IPythonCellExecuteCellJump<CR>", desc = "Execute cell and jump next" },
      { "<C-c>e", "<cmd>IPythonCellExecuteCellVerbose<CR>", desc = "Execute cell" },
      { "<C-c>j", "<cmd>IPythonCellExecuteCellJumpVerbose<CR>", desc = "Execute cell and jump next" },
      { "<C-c>l", "<cmd>IPythonCellClear<CR>", desc = "Clear IPython screen" },
      { "[c", "<cmd>IPythonCellPrevCell<CR>", mode = { "n", "x" }, desc = "Prev cell" },
      { "]c", "<cmd>IPythonCellNextCell<CR>", mode = { "n", "x" }, desc = "Next cell" },
      { "<C-c>O", "<cmd>IPythonCellInsertAbove<CR>a", desc = "Insert cell above" },
      { "<C-c>o", "<cmd>IPythonCellInsertBelow<CR>a", desc = "Insert cell below" },
      { "<C-c>i", "a# %% ", desc = "Insert cell title" },
    },
  },
  -- {
  --   "dccsillag/magma-nvim",
  --   build = ":UpdateRemotePlugins",
  --   commit = "0ab5ef297bf98d69f03bb069533444c14cd53383",
  --   keys = {
  --     { "<leader>r", "<cmd>MagmaEvaluateOperator<CR>", silent = true, expr = true },
  --     { "<leader>rr", "<cmd>MagmaEvaluateLine<CR>", silent = true },
  --     { "<leader>r", "<cmd>MagmaEvaluateVisual<CR>", mode = "x", silent = true },
  --     { "<leader>rc", "<cmd>MagmaReevaluateCell<CR>", silent = true },
  --     { "<leader>rd", "<cmd>MagmaDelete<CR>", silent = true },
  --     { "<leader>ro", "<cmd>MagmaShowOutput<CR>", silent = true },
  --   },
  --   cmd = {
  --     "MagmaInit",
  --   },
  -- },
}
