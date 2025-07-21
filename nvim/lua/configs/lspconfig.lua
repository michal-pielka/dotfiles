local lspconfig = require "lspconfig"
local nvlsp = require "nvchad.configs.lspconfig"

local servers = { "html", "cssls", "pyright", "jdtls", "rust_analyzer", "gopls" }

for _, lsp in ipairs(servers) do
  local opts = {
    on_attach = nvlsp.on_attach,
    on_init = nvlsp.on_init,
    capabilities = nvlsp.capabilities,
  }

  opts.capabilities.offsetEncoding = { "utf-16" }

  if lsp == "rust_analyzer" then
    opts.settings = {
      ["rust-analyzer"] = {
        checkOnSave = {
          command = "clippy",
        },
      },
    }
  elseif lsp == "gopls" then
    opts.settings = {
      gopls = {
        analyses = { unusedparams = true },
        staticcheck = true,
        gofumpt = true,
      },
    }
  end

  lspconfig[lsp].setup(opts)
end

-- clangd should be set up directly here
local clangd_opts = {
  on_attach = nvlsp.on_attach,
  on_init = nvlsp.on_init,
  capabilities = nvlsp.capabilities,
  init_options = {
    fallbackFlags = { "-std=c17", "-Iinclude" }, -- Customize as needed
  },
}
clangd_opts.capabilities.offsetEncoding = { "utf-16" }

lspconfig.clangd.setup(clangd_opts)
