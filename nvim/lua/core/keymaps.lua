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

-- Center screen when going half a page up/down
map('<C-d>', '<C-d>zz', 'Half page down & center')
map('<C-u>', '<C-u>zz', 'Half page up & center')

-- Make split navigation easier
map('<C-h>', '<C-w><C-h>', 'Move focus to the left window')
map('<C-l>', '<C-w><C-l>', 'Move focus to the right window')
map('<C-j>', '<C-w><C-j>', 'Move focus to the lower window')
map('<C-k>', '<C-w><C-k>', 'Move focus to the upper window')

-- Buffer navigation
map('<C-,>', ':bprevious<CR>', 'Previous buffer')
map('<C-.>', ':bnext<CR>', 'Next buffer')

-- Close buffer
map('<C-q>', ':bdelete<CR>', 'Delete buffer')


-- Unmap LSP defaults - replaced in lspconfig
local function unmap(mode, lhs)
  vim.keymap.set(mode, lhs, "<Nop>", { desc = "Disabled" })
end

unmap('n', 'grn')
unmap('n', 'gra')
unmap('n', 'grr')
unmap('n', 'gri')
unmap('n', 'grt')
