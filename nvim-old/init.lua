-- =============================================================================
-- |                           CORE CONFIGURATION                            |
-- =============================================================================
-- Set leader key. This must be done before plugins are loaded.
vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

-- Load core modules for settings, keymaps, and autocommands.
-- These are loaded first to ensure a consistent environment for plugins.
require 'core/options'
require 'core/keymaps'
require 'core/autocmds'

-- =============================================================================
-- |                             PLUGIN MANAGER                              |
-- =============================================================================
-- Bootstrap lazy.nvim: a modern plugin manager for Neovim.
-- It will be automatically installed if it's not already present.
local lazypath = vim.fn.stdpath 'data' .. '/lazy/lazy.nvim'
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  local lazyrepo = 'https://github.com/folke/lazy.nvim.git'
  vim.fn.system { 'git', 'clone', '--filter=blob:none', '--branch=stable', lazyrepo, lazypath }
end
vim.opt.rtp:prepend(lazypath)

-- =============================================================================
-- |                              PLUGIN SETUP                               |
-- =============================================================================
-- Configure and load plugins using lazy.nvim.
-- All plugin specifications are in the `lua/custom/plugins/` directory.
require('lazy').setup({
  -- All plugins are imported from the `plugins` module.
  { import = 'plugins' },
}, {
  -- Configure lazy.nvim's UI for a better visual experience.
  ui = {
    -- Use Nerd Font icons if available, otherwise fall back to standard characters.
    icons = vim.g.have_nerd_font and {} or {
      cmd = '⌘',
      config = '🛠',
      event = '📅',
      ft = '📂',
      init = '⚙',
      keys = '🗝',
      plugin = '🔌',
      runtime = '💻',
      require = '🌙',
      source = '📄',
      start = '🚀',
      task = '📌',
      lazy = '💤 ',
    },
  },
})
