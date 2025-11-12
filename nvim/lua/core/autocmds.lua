-- IMPORTANT
-- The following autocmd is only meant to be used on asahi linux
-- we use native clangd since mason fails to install it
vim.api.nvim_create_autocmd({ "FileType" }, {
  pattern = { "c", "cpp" },
  callback = function()
    vim.lsp.start {
      name = "clangd",
      cmd = { "/usr/bin/clangd" },
      root_dir = vim.fs.dirname(
        vim.fs.find({ ".git", "compile_commands.json", "compile_flags.txt" }, { upward = true })[1]
      ),
    }
  end,
})

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
