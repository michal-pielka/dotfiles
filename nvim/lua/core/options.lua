-- Line numbers
vim.o.number = true
vim.o.relativenumber = true

-- Enable mouse mode, useful
vim.o.mouse = 'a'

-- Enable break indent
vim.o.wrap = true
vim.o.breakindent = true

-- Save undo history
vim.o.undofile = true

-- Case-insensitive searching UNLESS \C or one or more capital letters in the search term
vim.o.ignorecase = true
vim.o.smartcase = true

-- Keep signcolumn on by default
vim.o.signcolumn = 'yes'

-- Decrease update time
vim.o.updatetime = 250

-- Decrease mapped sequence wait time
vim.o.timeoutlen = 300

-- Configure how new splits should be opened
vim.o.splitright = true
vim.o.splitbelow = true

-- Preview substitutions live, in a new window, for example :%s/foo/bar/g
vim.o.inccommand = 'split'

-- Show which line your cursor is on
vim.o.cursorline = true

-- Minimal number of screen lines to keep above and below the cursor.
vim.o.scrolloff = 10

-- Tabs
vim.opt.tabstop = 4
vim.opt.shiftwidth = 4

-- Floating window styling
vim.opt.winborder = 'single'

-- Transparent status bar
vim.cmd(":hi statusline guibg=NONE")

-- Sync clipboard between OS and Neovim.
vim.schedule(function()
  vim.o.clipboard = 'unnamedplus'
end)

-- Remove the '~' char on end of buffer
vim.opt.fillchars:append({ eob = ' ' })

-- Block cursor in insert mode
vim.opt.guicursor = ""
