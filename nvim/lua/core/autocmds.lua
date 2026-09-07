-- NOTE: clangd used to be started here with vim.lsp.start() *in addition to*
-- the vim.lsp.enable('clangd') in plugins/lspconfig.lua, which attached two
-- clangd clients to every C/C++ buffer - duplicate diagnostics and two full
-- indexing passes. It is now configured in one place, in plugins/lspconfig.lua
-- (still pointing at the system clangd, since Mason has no aarch64 build).

-- Highlight when yanking text
vim.api.nvim_create_autocmd('TextYankPost', {
	desc = 'Highlight when yanking text',
	callback = function()
		vim.hl.on_yank()
	end,
})

-- No auto continue comments on new line
vim.api.nvim_create_autocmd("FileType", {
	group = vim.api.nvim_create_augroup("no_auto_comment", {}),
	callback = function()
		vim.opt_local.formatoptions:remove({ "c", "x", "o" })
	end,
})
