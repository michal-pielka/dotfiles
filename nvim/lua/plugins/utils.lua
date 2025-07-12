return {
  -- Vim-surround
  {
    "tpope/vim-surround",
    lazy = false,
  },
  -- bufdelete - for closing current buffer/tab
  {
    "famiu/bufdelete.nvim",
    lazy = false,
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
