return {
  'echasnovski/mini.nvim',
  dependencies = { 'nvim-treesitter/nvim-treesitter-textobjects' },
  config = function()
    -- Powerful Around/Inside textobjects with Treesitter support
    require('mini.ai').setup {
      n_lines = 500,
      custom_textobjects = {
        -- Functions: 'if' (inside function), 'af' (around function)
        f = require('mini.ai').gen_spec.treesitter { a = '@function.outer', i = '@function.inner' },
        -- Classes: 'ic', 'ac'
        c = require('mini.ai').gen_spec.treesitter { a = '@class.outer', i = '@class.inner' },
        -- Parameters: 'ia', 'aa'
        a = require('mini.ai').gen_spec.treesitter { a = '@parameter.outer', i = '@parameter.inner' },
        -- Conditionals: 'i?', 'a?'
        ['?'] = require('mini.ai').gen_spec.treesitter { a = '@conditional.outer', i = '@conditional.inner' },
        -- Loops: 'il', 'al'
        -- l = require('mini.ai').gen_spec.treesitter { a = '@loop.outer', i = '@loop.inner' },
      },
    }

    -- Simple and easy statusline.
    --  You could remove this setup call if you don't like it,
    --  and try some other statusline plugin
    local statusline = require 'mini.statusline'
    -- set use_icons to true if you have a Nerd Font
    statusline.setup { use_icons = vim.g.have_nerd_font }

    -- You can configure sections in the statusline by overriding their
    -- default behavior. For example, here we set the section for
    -- cursor location to LINE:COLUMN
    ---@diagnostic disable-next-line: duplicate-set-field
    statusline.section_location = function()
      return '%2l:%-2v'
    end
  end,
}
