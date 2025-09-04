return {
  'ibhagwan/fzf-lua',
  event = 'VimEnter',
  dependencies = {
    { 'nvim-tree/nvim-web-devicons', enabled = vim.g.have_nerd_font },
  },
  enabled=false,
  config = function()
    local fzf = require('fzf-lua')

    fzf.setup {
      keymap = {
        builtin = {
          ['<c-j>'] = 'down',
          ['<c-k>'] = 'up',
          ['<c-d>'] = 'preview-half-page-down',
          ['<c-u>'] = 'preview-half-page-up',
          ['<c-q>'] = 'toggle-all',
          ['<c-x>'] = 'toggle',
        },
        fzf = {
          ['ctrl-j'] = 'down',
          ['ctrl-k'] = 'up',
          ['ctrl-d'] = 'preview-half-page-down',
          ['ctrl-u'] = 'preview-half-page-up',
          ['ctrl-q'] = 'toggle-all',
          ['ctrl-x'] = 'toggle',
        },
      },
      fzf_opts = {
        ['--layout'] = 'reverse',
        ['--info'] = 'inline',
		['--margin'] = '1%,1%',
      },
      files = {
        prompt = 'files> ',
        fd_opts = [[--color=never --type f --hidden --follow --exclude .git]],
      },
      grep = {
        prompt = 'grep> ',
        rg_opts = [[--hidden --column --line-number --no-heading --color=never --smart-case]],
      },
      marks = {
        prompt = 'marks> ',
        marks = '%a', -- only user marks (a-z)
      },
      oldfiles = {
        include_current_session = true,
        stat_file = true,
      },
      buffers = {
        prompt = 'buffers> ',
        sort_lastused = true,
        ignore_current_buffer = false,
      },
      help = { prompt = 'help> ' },
      keymaps = { prompt = 'keymaps> ' },
      diagnostics = {
        prompt = 'diagnostics> ',
        icons = true,
        cwd_only = false,
      },
      lsp = { icons = true },
      blines = {
        prompt = 'buffer lines> ',
        previewer = false,
      },
    }

    map('<leader>F', fzf.git_files, 'search project files')
    map('<leader>f', fzf.files, 'search files')
    map('<leader>g', fzf.live_grep, 'search grep')
    map('<leader>b', fzf.buffers, 'buffers')
    map('<leader>sk', fzf.keymaps, 'search keymaps')
    map('<leader>ss', fzf.builtin, 'select pickers')
    map('<leader>sd', fzf.diagnostics_workspace or fzf.diagnostics, 'search diagnostics')
    map('<leader>sn', function()
      fzf.files { cwd = vim.fn.stdpath('config'), prompt = 'nvim config> ' }
    end, 'config files')
  end,
}
