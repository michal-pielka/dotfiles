return {
  'rcarriga/nvim-notify',
  config = function()
    require('notify').setup {
      stages = 'fade_in_slide_out',
      timeout = 3000,
      render = 'minimal',
      minimum_width = 0,
      max_width = function()
        local max = math.floor(vim.o.columns * 0.4)
        return math.max(60, max)
      end,
      max_height = function()
        return math.floor(vim.o.lines * 0.75)
      end,
      fps = 60,
      icons = {
        ERROR = '',
        WARN = '',
        INFO = '',
        DEBUG = '',
        TRACE = '✎',
      },
    }
    vim.notify = require 'notify'
  end,
}
