return {
  'folke/noice.nvim',
  event = 'VeryLazy',
  opts = {
    lsp = {
      signature = {
        auto_open = {
          enabled = false,
        },
      },
    },
  },
  dependencies = {
    'MunifTanjim/nui.nvim',
    'rcarriga/nvim-notify',
  },
}
