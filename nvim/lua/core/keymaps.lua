-- Global keymap helper
function _G.map(lhs, rhs, desc)
  vim.keymap.set('n', lhs, rhs, { desc = desc })
end

-- Writing and quitting
map('<leader>w', '<CMD>write<CR>', 'Write')
map('<leader>q', '<CMD>quit<CR>', 'Quit')

-- Clear highlights on search when pressing <Esc> in normal mode
map('<Esc>', '<cmd>nohlsearch<CR>', 'Clear search highlights')

-- Switch to normal mode using jk/kj
vim.keymap.set('i', 'jk', '<Esc>', { desc = 'Exit insert mode' })
vim.keymap.set('i', 'kj', '<Esc>', { desc = 'Exit insert mode' })

-- Make split navigation easier
map('<Left>', '<C-w><C-h>', 'Move focus to the left window')
map('<Right>', '<C-w><C-l>', 'Move focus to the right window')
map('<Down>', '<C-w><C-j>', 'Move focus to the lower window')
map('<Up>', '<C-w><C-k>', 'Move focus to the upper window')

-- Buffer navigation
map('>', ':bnext<CR>', 'Next buffer')
map('<', ':bprevious<CR>', 'Previous buffer')

-- Close buffer
map('<C-q>', ':bdelete<CR>', 'Delete buffer')

vim.keymap.set("n", "<leader>td", function()
  vim.diagnostic.enable(not vim.diagnostic.is_enabled())
end, { desc = "Toggle LSP diagnostics (global)" })

-- Switch to previous buffer - basically a remap to <C-6>
map('<leader>r', '<CMD>e #<CR>', 'Alternate buffers')

map('H', '^', 'Go to line beginning')
map('L', '$', 'Go to line ending')

-- Easy access to the norm command
vim.keymap.set({ 'n', 'v' }, '<leader>n', ':norm ', { desc = 'Norm command' })

-- Map arrow keys to gj/gk - useful for going down a visible line in a long line.
-- map('<Up>', 'gk', 'Go up a visible line')
-- map('<Down>', 'gj', 'Go down a visible line')
