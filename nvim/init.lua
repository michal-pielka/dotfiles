-- Set leader key
vim.g.mapleader = " "

-- Set cache path for base46 themes
vim.g.base46_cache = vim.fn.stdpath "data" .. "/nvchad/base46/"

-- Bootstrap lazy.nvim
local lazypath = vim.fn.stdpath "data" .. "/lazy/lazy.nvim"
if not vim.uv.fs_stat(lazypath) then
  local repo = "https://github.com/folke/lazy.nvim.git"
  vim.fn.system { "git", "clone", "--filter=blob:none", repo, "--branch=stable", lazypath }
end
vim.opt.rtp:prepend(lazypath)

-- Load all plugins from the plugins directory
require("lazy").setup({
  {
    "NvChad/NvChad",
    lazy = false,
    branch = "v2.5",
    import = "nvchad.plugins",
  },
  { import = "plugins" }, -- This will load all files in lua/plugins/
}, require "configs.lazy") -- NvChad's recommended lazy.nvim config

-- Load theme and statusline
dofile(vim.g.base46_cache .. "defaults")
dofile(vim.g.base46_cache .. "statusline")

-- Load custom configurations
require "core.options"
require "core.keymaps"
require "core.autocmds"

print "happy_coding;)"
