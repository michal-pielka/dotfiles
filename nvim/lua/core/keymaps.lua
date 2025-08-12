vim.keymap.set('n', '<leader>o', ':update<CR> :source<CR>')

-- Writing and quitting
vim.keymap.set('n', '<leader>w', ':write<CR>')
vim.keymap.set('n', '<leader>q', ':quit<CR>')

-- Clear highlights on search when pressing <Esc> in normal mode
vim.keymap.set('n', '<Esc>', '<cmd>nohlsearch<CR>')

-- Switch to normal mode using jk
vim.keymap.set('i', 'jk', '<Esc>')

-- Center screen when going half a page up/down
vim.keymap.set('n', '<C-d>', '<C-d>zz')
vim.keymap.set('n', '<C-u>', '<C-u>zz')
