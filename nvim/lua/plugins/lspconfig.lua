return {
  'neovim/nvim-lspconfig',
  dependencies = {
    { 'mason-org/mason.nvim', opts = {} },
    'mason-org/mason-lspconfig.nvim',
    'WhoIsSethDaniel/mason-tool-installer.nvim',
    -- Keep blink for completion capabilities
    'saghen/blink.cmp',
  },
  config = function()
    vim.api.nvim_create_autocmd('LspAttach', {
      group = vim.api.nvim_create_augroup('minimal-lsp-attach', { clear = true }),
      callback = function(event)
        local function bufmap(lhs, rhs, desc)
          vim.keymap.set('n', lhs, rhs, { desc = desc, buffer = event.buf })
        end

        bufmap('gd', vim.lsp.buf.definition, 'Go to Definition')
        bufmap('grr', vim.lsp.buf.references, 'Go to References')
        bufmap('grn', vim.lsp.buf.rename, 'Rename Symbol')
        bufmap('K', vim.lsp.buf.hover, 'Hover Docs')
        -- bufmap('gD', vim.lsp.buf.declaration, 'Go to Declaration')
        -- bufmap('gi', vim.lsp.buf.implementation, 'Go to Implementation')
        -- bufmap('gt', vim.lsp.buf.type_definition, 'Go to Type Definition')
        -- bufmap('<leader>ca', vim.lsp.buf.code_action, 'Code Action')
        -- bufmap('<C-k>', vim.lsp.buf.signature_help, 'Signature Help')

        -- Diagnostics navigation
        bufmap('<leader>d', vim.diagnostic.open_float, 'Show Diagnostics')
        bufmap('[d', function() vim.diagnostic.jump { count = -1 } end, 'Prev Diagnostic')
        bufmap(']d', function() vim.diagnostic.jump { count = 1 } end, 'Next Diagnostic')

        bufmap('<leader>l', function()
          vim.lsp.buf.format { async = true }
        end, 'Format Buffer')
      end,
    })

    -- Basic diagnostic appearance
    vim.diagnostic.config {
      severity_sort = true,
      virtual_text = true,
      underline = true,
      update_in_insert = false,
    }

    -- Capabilities (augment with blink)
    local capabilities = vim.tbl_deep_extend(
      'force',
      vim.lsp.protocol.make_client_capabilities(),
      require('blink.cmp').get_lsp_capabilities()
    )

    -- Mason-managed servers (auto-installed)
	local servers = {
	  lua_ls = {
		settings = {
		  Lua = {
			completion = { callSnippet = 'Replace' },
			diagnostics = { globals = { 'vim' } },
		  },
		},
	  },
	  pyrefly = {},
	  ruff = {
		-- Lint diagnostics stay on; pyrefly owns hover.
		on_attach = function(client)
		  client.server_capabilities.hoverProvider = false
		end,
	  },
	  rust_analyzer = {},
	  gopls = {},
	  bashls = {},
	  ts_ls = {},
	}

	-- Not in Mason (system-installed).
	-- Mason has no clangd build for aarch64/asahi, so point at the Fedora
	-- package. This is the ONLY place clangd is set up - do not also call
	-- vim.lsp.start() for it, or each buffer gets two clients.
	local manual_servers = {
	  clangd = {
		cmd = {
		  '/usr/bin/clangd',
		  '--background-index',
		  '--completion-style=detailed',
		  -- Arduino/embedded headers are not meant to be included directly.
		  '--header-insertion=never',
		},
		-- .clangd and compile_commands.json are generated per-project (see
		-- the ESP32 project's esp32/gen-compile-commands.sh); either one is
		-- enough to anchor the project root.
		root_markers = { 'compile_commands.json', 'compile_flags.txt', '.clangd', '.git' },
	  },
	}

    -- Ensure tools/servers installed via mason-tool-installer
    local ensure = vim.tbl_keys(servers)
    require('mason-tool-installer').setup { ensure_installed = ensure }

    -- Required to be set up between mason and lspconfig
    require('mason-lspconfig').setup {
      ensure_installed = {},
      automatic_installation = false,
    }

    -- Use native vim.lsp.config + vim.lsp.enable (Neovim 0.11+)
    local all_servers = vim.tbl_extend('force', servers, manual_servers)
    for server_name, opts in pairs(all_servers) do
      opts.capabilities = vim.tbl_deep_extend('force', {}, capabilities, opts.capabilities or {})
      vim.lsp.config(server_name, opts)
      vim.lsp.enable(server_name)
    end
  end,
}
