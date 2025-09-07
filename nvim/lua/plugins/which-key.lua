return {

  'folke/which-key.nvim',
  event = 'VimEnter',
  opts = {
    delay = 1000,
	preset = "helix",
	icons = {
		mappings = false,
	},

    spec = {
      { '<leader>s', group = 'search' },
      { '<leader>t', group = 'toggle' },
      { '<leader>h', group = 'git hunk', mode = { 'n', 'v' } },
    },
  },
}
