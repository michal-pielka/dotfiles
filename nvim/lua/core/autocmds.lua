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
