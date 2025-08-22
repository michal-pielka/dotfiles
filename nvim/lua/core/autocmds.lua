-- Highlight when yanking text
vim.api.nvim_create_autocmd('TextYankPost', {
	desc = 'Highlight when yanking text',
	callback = function()
		vim.hl.on_yank()
	end,
})
