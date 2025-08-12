-- Get the default NvChad mappings
require "nvchad.mappings"

-- Add your own mappings here
local map = vim.keymap.set

-- Better command mode access
map("n", ";", ":", { desc = "CMD enter command mode" })

-- Find next using ' since ; is used for command mode
map("n", "'", ";")

-- Exit insert mode quickly
map("i", "jk", "<ESC>", { desc = "Exit insert mode" })

-- Close buffer using bufdelete.nvim
map("n", "<leader>q", "<cmd>Bdelete<CR>", { desc = "Close buffer" })

-- Open file tree with <leader>e
map("n", "<leader>e", "<cmd>NvimTreeToggle<CR>", { desc = "Toggle file tree" })
