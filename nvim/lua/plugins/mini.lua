return {
  'echasnovski/mini.nvim',
  dependencies = {
    'nvim-treesitter/nvim-treesitter-textobjects',
  },
  config = function()
    -- mini.ai : Powerful Around/Inside textobjects with Treesitter support
    local ai = require('mini.ai')
    ai.setup {
      n_lines = 500,
      custom_textobjects = {
        f = ai.gen_spec.treesitter { a = '@function.outer',   i = '@function.inner' },
        c = ai.gen_spec.treesitter { a = '@class.outer',      i = '@class.inner' },
        a = ai.gen_spec.treesitter { a = '@parameter.outer',  i = '@parameter.inner' },
        i = ai.gen_spec.treesitter { a = '@conditional.outer', i = '@conditional.inner' },
        -- Uncomment if you want loop textobjects:
        -- l = ai.gen_spec.treesitter { a = '@loop.outer', i = '@loop.inner' },
      },
    }

    -- mini.pairs : Lightweight auto pairs (replaces nvim-autopairs)
    require('mini.pairs').setup({
      -- You can leave empty for defaults.
      -- Below are examples of tweaks you might want; uncomment/edit as needed.

      -- modes = { insert = true, command = false, terminal = false },

      -- Skip pairing in certain contexts (example: no quotes inside comments)
      -- skip = {
      --   -- Function receiving a line and cursor col (1-indexed); return true to skip
      --   -- Example: don't auto-pair quotes inside comments
      --   function(buf_id)
      --     local cs = vim.bo[buf_id].commentstring
      --     if cs == '' then return false end
      --     local line = vim.api.nvim_get_current_line()
      --     local col = vim.api.nvim_win_get_cursor(0)[2] + 1
      --     -- naive check: if the part before cursor looks like it's inside a comment delimiter
      --     return line:sub(1, col):match('%s' .. vim.pesc(cs:match('^(.*)%%s.*') or '')) ~= nil
      --   end,
      -- },

      -- mappings = {
      --   -- Example: disable angle bracket pairing if you rarely need <>
      --   ['<'] = { action = 'open', pair = '<>', neigh_pattern = '[^\\].', register = { cr = false } },
      -- },
    })

    -- mini.statusline
    local statusline = require('mini.statusline')
    statusline.setup { use_icons = vim.g.have_nerd_font }

    ---@diagnostic disable-next-line: duplicate-set-field
    statusline.section_location = function()
      return '%2l:%-2v'
    end
  end,
}
