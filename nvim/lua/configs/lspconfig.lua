-- Load NvChad defaults
require("nvchad.configs.lspconfig").defaults()

local lspconfig = require "lspconfig"

-- Add HTML, CSS, Python, C/C++, Java, and Rust LSP servers
local servers = { "html", "cssls", "pyright", "clangd", "jdtls", "rust_analyzer", "gopls" }
local nvlsp = require "nvchad.configs.lspconfig"

for _, lsp in ipairs(servers) do
  local opts = {
    on_attach = nvlsp.on_attach,
    on_init = nvlsp.on_init,
    capabilities = nvlsp.capabilities,
  }

  -- Force uniform offset encoding across all LSP clients
  opts.capabilities.offsetEncoding = { "utf-16" }

-- C++, C flags
if lsp == "clangd" then
  local filename = vim.api.nvim_buf_get_name(0)
  if filename:match("%.cpp$") or filename:match("%.cc$") or filename:match("%.cxx$") then
    opts.init_options = {
      fallbackFlags = { "-std=c++17" },
    }
  else
    opts.init_options = {
      fallbackFlags = { "-std=c17", "-Iinclude" },
    }
  end
end

  -- Rust analyzer specific settings
  if lsp == "rust_analyzer" then
    opts.settings = {
      ["rust-analyzer"] = {
        checkOnSave = {
          command = "clippy", -- Enable clippy on save
        },
      },
    }
  end

  -- Go 
  if lsp == "gopls" then
    opts.settings = {
      gopls = {
        analyses = {
          unusedparams = true,
        },
        staticcheck = true,
        gofumpt = true,
      }
    }
  end

  lspconfig[lsp].setup(opts)
end
