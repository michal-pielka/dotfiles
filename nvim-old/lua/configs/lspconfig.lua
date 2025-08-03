-- Load NvChad defaults
require("nvchad.configs.lspconfig").defaults()

local lspconfig = require "lspconfig"
local nvlsp    = require "nvchad.configs.lspconfig"

-- Add HTML, CSS, Python, C/C++, Java, Rust, Go, and Ruff LSP servers
local servers = { "html", "cssls", "pyright", "ruff", "clangd", "jdtls", "rust_analyzer", "gopls" }

for _, lsp in ipairs(servers) do
  local opts = {
    on_attach    = nvlsp.on_attach,
    on_init      = nvlsp.on_init,
    capabilities = nvlsp.capabilities,
  }

  -- Force uniform offset encoding across all LSP clients
  opts.capabilities.offsetEncoding = { "utf-16" }

  -- Specialize Pyright to type-check only (disable its diagnostics)
  if lsp == "pyright" then
    -- keep type checking, disable its publishDiagnostics handler
    opts.settings = {
      python = {
        analysis = {
          typeCheckingMode    = "basic",         -- or "strict"
          diagnosticMode      = "openFilesOnly", -- optional tuning
          autoSearchPaths     = true,
          useLibraryCodeForTypes = true,
        },
      },
    }
    -- Prevent Pyright from sending lint diagnostics
    opts.handlers = {
      ["textDocument/publishDiagnostics"] = function() end,
    }
  end

  -- Rust analyzer specific settings
  if lsp == "rust_analyzer" then
    opts.settings = {
      ["rust-analyzer"] = {
        checkOnSave = { command = "clippy" },
      },
    }
  end

  -- Go (gopls) settings
  if lsp == "gopls" then
    opts.settings = {
      gopls = {
        analyses        = { unusedparams = true },
        staticcheck     = true,
        gofumpt         = true,
      },
    }
  end

  -- Setup each server
  lspconfig[lsp].setup(opts)
end

-- Custom settings for clangd via autocmd
vim.api.nvim_create_autocmd("FileType", {
  pattern = { "c", "cpp" },
  callback = function()
    local clangd_opts = {
      on_attach    = nvlsp.on_attach,
      on_init      = nvlsp.on_init,
      capabilities = nvlsp.capabilities,
    }
    clangd_opts.capabilities.offsetEncoding = { "utf-16" }

    if vim.bo.filetype == "cpp" then
      clangd_opts.init_options = { fallbackFlags = { "-std=c++17" } }
    else
      clangd_opts.init_options = { fallbackFlags = { "-std=c17", "-Iinclude" } }
    end

    lspconfig.clangd.setup(clangd_opts)
  end,
})
