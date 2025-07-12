return {
  -- Vim-surround
  {
    "tpope/vim-surround",
    keys = { "ys", "ds", "cs", "S" }, -- Load on keypress
  },
  -- bufdelete - for closing current buffer/tab
  {
    "famiu/bufdelete.nvim",
    cmd = "Bdelete", -- Load when command is used
  },
  -- markdown-preview
  {
    "iamcco/markdown-preview.nvim",
    build = "cd app && npm install",
    ft = { "markdown" },
    config = function()
      vim.g.mkdp_auto_start = 0 -- set to 1 to auto open preview
      vim.g.mkdp_auto_close = 1 -- closes preview when buffer is closed
    end,
  },
}
