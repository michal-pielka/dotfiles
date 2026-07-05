return {
  'folke/snacks.nvim',
  lazy = false,
  priority = 1000,
  ---@type snacks.Config
  opts = {
    notifier = {
      -- Use the default notifier settings.
    },
    picker = {
      previewers = {
        diff = { style = 'terminal' },
      },
      win = {
        input = {
          keys = {
            ['<C-u>'] = { 'preview_scroll_up', mode = { 'i', 'n' } },
            ['<C-d>'] = { 'preview_scroll_down', mode = { 'i', 'n' } },
          },
        },
        list = {
          keys = {
            ['<C-u>'] = { 'preview_scroll_up', mode = { 'i', 'n' } },
            ['<C-d>'] = { 'preview_scroll_down', mode = { 'i', 'n' } },
          },
        },
      },
    },
  },
  keys = {
    { '<leader>f', function() Snacks.picker.files() end, desc = 'Snacks: find files' },
    { '<leader>F', function() Snacks.picker.git_files() end, desc = 'Snacks: git files' },
    { '<leader>g', function() Snacks.picker.grep() end, desc = 'Snacks: live grep' },
    { '<leader>b', function() Snacks.picker.buffers() end, desc = 'Snacks: buffers' },
    { '<leader>/', function() Snacks.picker.lines() end, desc = 'Snacks: buffer lines' },

    -- Search (<leader>s...) prefix -------------------------------------------
    {
      '<leader>sn',
      function() Snacks.picker.files({ cwd = vim.fn.expand('~/.dotfiles') }) end,
      desc = 'Snacks: dotfiles',
    },
    { '<leader>ss', function() Snacks.picker.pickers() end, desc = 'Snacks: pickers' },
    { '<leader>sg', function() Snacks.picker.git_status() end, desc = 'Snacks: git status' },
    { '<leader>sd', function() Snacks.picker.diagnostics() end, desc = 'Snacks: diagnostics' },
    { '<leader>sh', function() Snacks.picker.help() end, desc = 'Snacks: help' },
    { '<leader>sk', function() Snacks.picker.keymaps() end, desc = 'Snacks: keymaps' },
  },
}
