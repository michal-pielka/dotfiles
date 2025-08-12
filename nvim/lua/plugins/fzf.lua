return {
  'ibhagwan/fzf-lua',
  event = 'VimEnter',
  dependencies = {
    { 'nvim-tree/nvim-web-devicons', enabled = vim.g.have_nerd_font },
  },
  config = function()
    local fzf = require('fzf-lua')

    fzf.setup {
      winopts = {
        height = 0.85,
        width  = 0.80,
        -- Position (row/col are relative to top-left; 0.50 would center)
        row = 0.50,
        col = 0.50,
        fullscreen = false,
		border = 'single',
		scrollbar = false,
        preview = {
		  border = 'single',
		  scrollbar = false,
          layout = 'flex',
          flip_columns = 120,  -- When columns < this, it flips orientation
          delay = 60,          -- Debounce preview update (ms) while you move
          winopts = {
            number = true,     -- Show line numbers in preview
            relativenumber = false,
          },
        },
      },

      ---------------------------------------------------------------------------
      -- Keymaps INSIDE the fzf-lua picker UI (NOT normal mode)
      ---------------------------------------------------------------------------
      keymap = {
        builtin = {
          ['<C-j>'] = 'down',        -- Move selection down
          ['<C-k>'] = 'up',          -- Move selection up
          ['<C-q>'] = 'toggle-all',  -- Toggle all entries (can then quickfix/send)
        },
        -- If external fzf binary is used, these apply in its interface
        fzf = {
          ['ctrl-j'] = 'down',
          ['ctrl-k'] = 'up',
          ['ctrl-q'] = 'toggle-all',
        },
      },

      ---------------------------------------------------------------------------
      -- Low-level fzf command-line options (tweak look/feel)
      ---------------------------------------------------------------------------
      fzf_opts = {
        ['--layout'] = 'reverse',  -- Prompt at top, results go down
        ['--info']   = 'inline',   -- Show match info inline
      },

      ---------------------------------------------------------------------------
      -- FILE PICKER settings: like Telescope find_files
      ---------------------------------------------------------------------------
      files = {
        prompt = 'Files> ',
        -- fd_opts: custom flags for the 'fd' command (fast file search).
        -- --hidden: include dotfiles
        -- --follow: follow symlinks
        -- --exclude .git: ignore git metadata directory
        fd_opts = [[--color=never --type f --hidden --follow --exclude .git]],
        -- actions = { ... } -- You can override default open/split/tab actions later if you like.
      },

      ---------------------------------------------------------------------------
      -- TEXT SEARCH (grep) settings: like Telescope live_grep / grep_string
      ---------------------------------------------------------------------------
      grep = {
        prompt = 'Grep> ',
        -- rg_opts: flags to ripgrep
        --   --hidden       include hidden files
        --   --column/line-number show position
        --   --smart-case   auto case sensitivity
        --   --no-heading   omit filename headings
        rg_opts = [[--hidden --column --line-number --no-heading --color=never --smart-case]],
      },

      ---------------------------------------------------------------------------
      -- Recently opened files (oldfiles)
      ---------------------------------------------------------------------------
      oldfiles = {
        include_current_session = true, -- Include files from current session
        stat_file = true,               -- Try to verify file still exists
      },

      ---------------------------------------------------------------------------
      -- Buffers list
      ---------------------------------------------------------------------------
      buffers = {
        prompt = 'Buffers> ',
        sort_lastused = true,          -- Put recently USED buffers near top
        ignore_current_buffer = false, -- Keep current buffer in the list
      },

      help      = { prompt = 'Help> ' },       -- :help topics
      keymaps   = { prompt = 'Keymaps> ' },    -- All key mappings
      diagnostics = {
        prompt = 'Diagnostics> ',
        icons = true,
        cwd_only = false,  -- false = include workspace (all project), true = restrict by current directory
      },

      lsp = {
        -- Shared settings for LSP-related pickers (if you use them later: definitions, references, etc.)
        icons = true,
      },

      ---------------------------------------------------------------------------
      -- Current buffer lines search (like Telescope current_buffer_fuzzy_find)
      ---------------------------------------------------------------------------
      blines = {
        prompt = 'Buffer Lines> ',
        previewer = false,  -- We already see the buffer; no preview needed
      },
    }

    ---------------------------------------------------------------------------
    -- Custom helper: live grep ONLY within currently open (listed) file buffers.
    -- Equivalent to your Telescope live_grep { grep_open_files = true } mapping.
    ---------------------------------------------------------------------------
    local function live_grep_open_files()
      local bufs = vim.api.nvim_list_bufs()
      local files = {}
      for _, b in ipairs(bufs) do
        -- 'buflisted' filters out special/no-name buffers
        if vim.api.nvim_buf_get_option(b, 'buflisted') then
          local name = vim.api.nvim_buf_get_name(b)
          -- We only want real files on disk (avoid [No Name])
          if name ~= '' and vim.loop.fs_stat(name) then
            table.insert(files, name)
          end
        end
      end
      if #files == 0 then
        vim.notify('No listed file buffers to grep', vim.log.levels.WARN)
        return
      end
      -- fzf.live_grep with explicit file list restricts search
      fzf.live_grep {
        files = files,
        prompt = 'Live Grep (Open Files)> ',
      }
    end

    ---------------------------------------------------------------------------
    -- SHORTHAND for mapping (normal mode):
    -- map('<keys>', function_or_callable, 'Description shown by which-key / :map')
    ---------------------------------------------------------------------------
    local function map(lhs, rhs, desc)
      vim.keymap.set('n', lhs, rhs, { desc = desc })
    end

    ---------------------------------------------------------------------------
    -- KEYMAPS (mirror your Telescope ones)
    -- <leader>sh : Help tags
    -- <leader>sk : Keymaps
    -- <leader>sf : Files
    -- <leader>ss : Builtin pickers list (fzf-lua equivalent list)
    -- <leader>sw : Grep string under cursor
    -- <leader>sg : Live grep across project
    -- <leader>sd : Diagnostics
    -- <leader>sr : Resume last picker
    -- <leader>s. : Recent (old) files
    -- <leader>/  : Buffers
    -- <leader><leader> : Current buffer fuzzy lines
    -- <leader>s/ : Live grep only in open buffers
    -- <leader>sn : Files in Neovim config directory
    ---------------------------------------------------------------------------

    map('<leader>sh', fzf.help_tags, '[S]earch [H]elp')
    map('<leader>sk', fzf.keymaps, '[S]earch [K]eymaps')
    map('<leader>sf', fzf.files, '[S]earch [F]iles')
    map('<leader>ss', fzf.builtin, '[S]earch [S]elect (All Pickers)')
    map('<leader>sw', fzf.grep_cword, '[S]earch current [W]ord')  -- Grep word under cursor
    map('<leader>sg', fzf.live_grep, '[S]earch by [G]rep')        -- Project live grep
    -- Some versions have diagnostics_workspace; if not, fallback to diagnostics
    map('<leader>sd', fzf.diagnostics_workspace or fzf.diagnostics, '[S]earch [D]iagnostics')
    map('<leader>sr', fzf.resume, '[S]earch [R]esume last picker')
    map('<leader>s.', fzf.oldfiles, '[S]earch Recent Files ("." repeat)')
    map('<leader>/', fzf.buffers, 'Find existing buffers')
    map('<leader><leader>', fzf.blines, 'Fuzzy search in current buffer')
    map('<leader>s/', live_grep_open_files, '[S]earch [/] in Open Files')
    map('<leader>sn', function()
      fzf.files {
        cwd = vim.fn.stdpath('config'), -- stdpath('config') = your Neovim config directory
        prompt = 'Neovim Config> ',
      }
    end, '[S]earch [N]eovim files')

    ---------------------------------------------------------------------------
    -- Tips / Next Steps:
    --   :FzfLua <Tab>     -> Lists every available built-in command (try this!)
    --   You can explore extras: git files/status/commits, LSP symbols, colorschemes, etc.
    --   For a more "dropdown" style (small height, no preview), you can override per call:
    --     fzf.files { winopts = { height = 0.4, width = 0.6, preview = { hidden = 'hidden' } } }
    --   To disable icons globally set 'winopts = { ... }, fzf_icons = false' or omit devicons dependency.
    --
    -- Troubleshooting:
    --   If "rg" not found: install ripgrep or remove grep pickers.
    --   If "fd" not found: fzf-lua will use 'find' (slower); consider installing fd.
    --   If you see placeholder squares instead of icons: install a Nerd Font and set vim.g.have_nerd_font = true before loading.
    ---------------------------------------------------------------------------
  end,
}
