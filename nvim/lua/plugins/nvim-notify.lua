return {
  "rcarriga/nvim-notify",
  config = function()
    require("notify").setup({
      stages = "fade_in_slide_out",
      timeout = 3000,
      background_colour = "#1a1b26",
      render = "minimal",
      max_width = 80,
      max_height = function()
        return math.floor(vim.o.lines * 0.75)
      end,
      fps = 60,
      icons = {
        ERROR = "",
        WARN = "",
        INFO = "",
        DEBUG = "",
        TRACE = "✎",
      },
    })
    vim.notify = require("notify") -- Optionally override the default vim.notify
  end,
}
