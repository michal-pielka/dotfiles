return {
  "stevearc/oil.nvim",
  lazy = false,
  dependencies = { "nvim-tree/nvim-web-devicons" },
  opts = {
    default_file_explorer = true,
    skip_confirm_for_simple_edits = true,
    view_options = {
      sort = { { "name", "asc" } },
    },
  },

	vim.keymap.set('n', '-', '<CMD>Oil<CR>', { desc = "Open Oil" } )
}
