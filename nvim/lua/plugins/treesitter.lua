return {
  'nvim-treesitter/nvim-treesitter',
  build = ':TSUpdate',
  main = 'nvim-treesitter.configs',
  opts = {
    auto_install = true,
    highlight = {
      enable = true,
    },
    -- language-aware textobjects: prefer these for af/if/ac/ic, etc.
    textobjects = {
      select = {
        enable = true,
        lookahead = true, -- jump forward to textobj
        keymaps = {
          -- outer/inner mappings commonly used
          ['ac'] = '@class.outer',
          ['ic'] = '@class.inner',
          ['af'] = '@function.outer',
          ['if'] = '@function.inner',
		  ['al'] = '@loop.outer',
		  ['il'] = '@loop.inner',
		  ['ai'] = '@conditional.outer',
		  ['ii'] = '@conditional.inner',
        },
      },
      -- optionally configure move/swap here if you want:
      -- move = { ... }, swap = { ... }
    },
  },
}
