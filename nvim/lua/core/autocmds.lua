-- Get the default NvChad autocmds
require "nvchad.autocmds"

-- Add your own autocmds here
local augroup = vim.api.nvim_create_augroup
local autocmd = vim.api.nvim_create_autocmd

-- Autogroup for your custom commands
local my_cmds = augroup("MyCustomAutocmds", { clear = true })

-- Set indentation to 4 spaces for specific filetypes
autocmd("FileType", {
  group = my_cmds,
  pattern = { "c", "cpp", "java", "go" },
  callback = function()
    vim.opt_local.shiftwidth = 4
    vim.opt_local.tabstop = 4
    vim.opt_local.expandtab = true
  end,
})

-- Highlight on yank
-- This creates a visual flash on the text you have just yanked.
autocmd("TextYankPost", {
  group = my_cmds,
  pattern = "*",
  callback = function()
    vim.highlight.on_yank({
      higroup = "IncSearch", -- The highlight group to use. 'IncSearch' is a good default.
      timeout = 200,       -- How long the highlight lasts in milliseconds.
    })
  end,
})
