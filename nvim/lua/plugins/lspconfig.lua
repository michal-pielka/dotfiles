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

        map('gd', vim.lsp.buf.definition,        'Go to Definition')
        map('grr', vim.lsp.buf.references,        'Go to References')
        map('grn', vim.lsp.buf.rename,    'Rename Symbol')
        map('K',  vim.lsp.buf.hover,             'Hover Docs')
        -- map('gD', vim.lsp.buf.declaration,       'Go to Declaration')
        -- map('gi', vim.lsp.buf.implementation,    'Go to Implementation')
        -- map('gt', vim.lsp.buf.type_definition,   'Go to Type Definition')
        -- map('<leader>ca', vim.lsp.buf.code_action,'Code Action', { 'n', 'x' })
        -- map('<C-k>', vim.lsp.buf.signature_help, 'Signature Help')

        -- Diagnostics navigation
		map('<leader>d', vim.diagnostic.open_float, 'Show Diagnostics')
        map('[d', vim.diagnostic.goto_prev, 'Prev Diagnostic')
        map(']d', vim.diagnostic.goto_next, 'Next Diagnostic')

        map('<leader>lf', function()
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

    -- Define servers
	local servers = {
	  lua_ls = {
		settings = {
		  Lua = {
			completion = { callSnippet = 'Replace' },
			diagnostics = { globals = { 'vim' } },
		  },
		},
	  },
	  pyright = {},
	  rust_analyzer = {},
	  gopls = {},
	  bashls = {},
	  ts_ls = {},
	  -- clangd = {},
	}

    -- Ensure tools/servers installed via mason-tool-installer
    local ensure = vim.tbl_keys(servers)
    require('mason-tool-installer').setup { ensure_installed = ensure }

    -- mason-lspconfig setup: let mason-tool-installer drive installation list
    require('mason-lspconfig').setup {
      ensure_installed = {},
      automatic_installation = false,
      handlers = {
        function(server_name)
          local opts = servers[server_name] or {}
          opts.capabilities = vim.tbl_deep_extend('force', {}, capabilities, opts.capabilities or {})
          require('lspconfig')[server_name].setup(opts)
        end,
      },
    }

    -- Enable all configured servers
    for server_name in pairs(servers) do
      vim.lsp.enable({ server_name })
    end
  end,
}
