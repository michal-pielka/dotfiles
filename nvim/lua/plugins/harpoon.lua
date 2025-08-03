return {
  'ThePrimeagen/harpoon',
  branch = 'harpoon2',
  dependencies = { 'nvim-lua/plenary.nvim', 'nvim-telescope/telescope.nvim' },
  config = function()
    -- Setup harpoon
    local harpoon = require 'harpoon'
    harpoon:setup()

    -- Your custom function to show harpoon marks in Telescope
    local conf = require('telescope.config').values
    local function toggle_telescope(harpoon_files)
      local file_paths = {}
      for _, item in ipairs(harpoon_files.items) do
        table.insert(file_paths, item.value)
      end

      require('telescope.pickers')
        .new({}, {
          prompt_title = 'Harpoon Marks',
          finder = require('telescope.finders').new_table {
            results = file_paths,
          },
          previewer = conf.file_previewer {},
          sorter = conf.generic_sorter {},
        })
        :find()
    end

    -- Set the keymap for your custom Telescope picker
    vim.keymap.set('n', '<leader>e', function()
      toggle_telescope(harpoon:list())
    end, {
      desc = 'Harpoon: Open UI',
    })
  end,
  keys = {
    -- Keymaps for adding files and navigating
    {
      '<leader>a',
      function()
        require('harpoon'):list():add()
      end,
      desc = 'Harpoon: Add file',
    },
    {
      '<leader>1',
      function()
        require('harpoon'):list():select(1)
      end,
      desc = 'Harpoon: Go to file 1',
    },
    {
      '<leader>2',
      function()
        require('harpoon'):list():select(2)
      end,
      desc = 'Harpoon: Go to file 2',
    },
    {
      '<leader>3',
      function()
        require('harpoon'):list():select(3)
      end,
      desc = 'Harpoon: Go to file 3',
    },
    {
      '<leader>4',
      function()
        require('harpoon'):list():select(4)
      end,
      desc = 'Harpoon: Go to file 4',
    },
    {
      '<leader>5',
      function()
        require('harpoon'):list():select(5)
      end,
      desc = 'Harpoon: Go to file 5',
    },
  },
}
