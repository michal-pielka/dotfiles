-- Get the default NvChad options
require "nvchad.options"

-- Add your own options here
local opt = vim.opt
local wo = vim.wo

-- Line numbers
wo.relativenumber = true
wo.number = true

-- Walk on empty characters
opt.virtualedit = "all"

-- Folding
opt.foldmethod = "expr"
opt.foldexpr = "nvim_treesitter#foldexpr()"
opt.foldenable = true
opt.foldlevel = 99 -- Open all folds by default
