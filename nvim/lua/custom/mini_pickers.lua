local M = {}

-- Helper: find the Git repository root (returns nil if not inside a repo)
local function find_git_root()
  local out = vim.fn.systemlist({ 'git', 'rev-parse', '--show-toplevel' })
  if vim.v.shell_error == 0 and out and out[1] and out[1] ~= '' then
    return out[1]
  end
  return nil
end

function M.setup_registry()
  local pick = require('mini.pick')
  local builtin = pick.builtin

  -- 1) Git status with diff preview
  pick.registry.git_status = function()
    local selection = builtin.cli({ command = { 'git', 'status', '-s' } }, {
      source = {
        name = 'Git Status',
        preview = function(buf_id, item)
          -- Extract file path from "git status -s" line
          local file = (vim.trim(item):match('%s+(.+)$')) or item

          -- Helper to write lines into the preview buffer
          local function set_buf(lines, ft)
            vim.bo[buf_id].modifiable = true
            vim.api.nvim_buf_set_lines(buf_id, 0, -1, false, lines or {})
            if ft then vim.bo[buf_id].filetype = ft end
            vim.bo[buf_id].modifiable = false
          end

          -- Show the diff for the selected file
          vim.fn.jobstart({ 'git', 'diff', '--', file }, {
            stdout_buffered = true,
            on_stdout = function(_, data)
              if data and #data > 0 and not (#data == 1 and data[1] == '') then
                set_buf(data, 'diff')
              else
                set_buf({ '<no diff>' }, 'diff')
              end
            end,
            on_stderr = function(_, data)
              if data and #data > 0 then set_buf(data, 'diff') end
            end,
          })
        end,
      },
    })

    -- Open the selected file
    if selection then
      local file = (vim.trim(selection):match('%s+(.+)$')) or selection
      vim.cmd.edit(vim.fn.fnameescape(file))
    end
  end

  -- 2) Dotfiles: browse files in ~/.dotfiles using the builtin files picker
  pick.registry.dotfiles = function()
    local dir = vim.fn.expand('~/.dotfiles')
    if vim.fn.isdirectory(dir) == 0 then
      vim.notify('Dotfiles directory not found: ' .. dir, vim.log.levels.WARN)
      return
    end

    return builtin.files(nil, {
      source = {
        name = 'Dotfiles',
        cwd = dir,
      },
    })
  end

  -- 3) Git project files: run "Pick files" from the Git repo root
  pick.registry.repository_files = function()
    local root = find_git_root()
    if not root then
      vim.notify('Not inside a Git repository.', vim.log.levels.WARN)
      return
    end

    return builtin.files(nil, {
      source = {
        name = 'Git Files',
        cwd = root,
      },
    })
  end

  -- 4) List all registered pickers and run the chosen one
  pick.registry.pickers = function()
    -- Collect all pickers registered in mini.pick
    local names = {}
    for name, fn in pairs(pick.registry) do
      if type(name) == 'string' and type(fn) == 'function' then
        table.insert(names, name)
      end
    end
    table.sort(names)

    -- Start a simple picker over picker names
    return pick.start({
      source = {
        name = 'Pick: pickers',
        items = names,

        -- Optional: tiny preview/hint
        preview = function(buf_id, item)
          local lines = {
            'Run picker: :Pick ' .. item,
            '',
            'Press <CR> to execute this picker.',
          }
          vim.bo[buf_id].modifiable = true
          vim.api.nvim_buf_set_lines(buf_id, 0, -1, false, lines)
          vim.bo[buf_id].filetype = 'help'
          vim.bo[buf_id].modifiable = false
        end,

        -- When you choose a name, invoke that picker
        choose = function(item)
          -- Equivalent to :Pick <item>
          -- Call directly to avoid shell escaping concerns
          local fn = pick.registry[item]
          if type(fn) == 'function' then
            fn()
          else
            -- Fallback: try the command if somehow not in registry
            vim.cmd('Pick ' .. item)
          end
        end,
      },
    })
  end
end

return M
