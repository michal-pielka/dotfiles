return {
  "ThePrimeagen/harpoon",
  branch = "harpoon2",
  dependencies = { "nvim-lua/plenary.nvim" },
  config = function()
    local harpoon = require("harpoon")

    -- REQUIRED
    harpoon:setup()

    -- Keymaps
    local map = vim.keymap.set
    local opts = { noremap = true, silent = true }

    -- Add current file to harpoon
    map("n", "<leader>a", function() harpoon:list():add() end, opts)

    -- Toggle harpoon quick menu
    map("n", "<leader>e", function() harpoon.ui:toggle_quick_menu(harpoon:list()) end, opts)

    -- Navigate files
    map("n", "<leader>1", function() harpoon:list():select(1) end, opts)
    map("n", "<leader>2", function() harpoon:list():select(2) end, opts)
    map("n", "<leader>3", function() harpoon:list():select(3) end, opts)
    map("n", "<leader>4", function() harpoon:list():select(4) end, opts)
  end,
}
