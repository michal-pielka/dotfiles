-- Highlight when yanking text
vim.api.nvim_create_autocmd('TextYankPost', {
	desc = 'Highlight when yanking text',
	callback = function()
		vim.hl.on_yank()
	end,
})

-- The following is only meant to be used on asahi linux
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
