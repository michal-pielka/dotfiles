-- Autocompletion
return {
  'saghen/blink.cmp',
  event = 'VimEnter',
  version = '1.*',
  --- @module 'blink.cmp'
  --- @type blink.cmp.Config
  opts = {
    keymap = {
      preset = 'none',
      ['<Tab>'] = { 'select_next', 'fallback' },
      ['<S-Tab>'] = { 'select_prev', 'fallback' },
      ['<CR>'] = { 'accept', 'fallback' },
    },

    appearance = {
      nerd_font_variant = 'mono',
    },

    completion = {
      -- Apply styling to completion menu and documentation
      menu = {
        scrollbar = false,
        draw = {
          padding = { 1, 1 },
          columns = { { 'kind_icon', separator = ' ' }, { 'label', separator = ' ' }, { 'kind', separator = ' ' } },
        },
      },
      documentation = {
        auto_show = true,
        auto_show_delay_ms = 300,
      },
    },

    sources = {
      default = { 'lsp', 'path', 'snippets',  },
    },

    fuzzy = { implementation = 'lua' },

    -- Apply styling to signature help window
    signature = {
      enabled = true,
    },
  },
}
