-- Set leader key. This must be done before plugins are loaded.
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- Load core modules for settings, keymaps, and autocommands.
require("core/options")
require("core/keymaps")
require("core/autocmds")

local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
	local lazyrepo = "https://github.com/folke/lazy.nvim.git"
	vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })
end
vim.opt.rtp:prepend(lazypath)

-- Configure and load plugins using lazy.nvim.
require("lazy").setup({
	-- All plugins are imported from the `plugins` module.
	{ import = "plugins" },
}, {
	-- Configure lazy.nvim's
	ui = {
		icons = vim.g.have_nerd_font and {} or {
			cmd = "⌘",
			config = "🛠",
			event = "📅",
			ft = "📂",
			init = "⚙",
			keys = "🗝",
			plugin = "🔌",
			runtime = "💻",
			require = "🌙",
			source = "📄",
			start = "🚀",
			task = "📌",
			lazy = "💤 ",
		},
	},
})
