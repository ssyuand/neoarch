-- custom.plugins.lspconfig
local on_attach = require("plugins.configs.lspconfig").on_attach
local capabilities = require("plugins.configs.lspconfig").capabilities

local lspconfig = require "lspconfig"
local servers = { "rust_analyzer", "bashls", "jdtls", "clangd", "pyright", "tsserver", "sumneko_lua", "jsonls" }

for _, lsp in ipairs(servers) do
  lspconfig[lsp].setup {
    on_attach = on_attach,
    capabilities = capabilities,
  }
end

--  global vim is undefined
lspconfig.sumneko_lua.setup {
  settings = {
    Lua = {
      diagnostics = {
        globals = { "vim" },
      },
    },
  },
}

vim.lsp.handlers["textDocument/publishDiagnostics"] = vim.lsp.with(vim.lsp.diagnostic.on_publish_diagnostics, {
  -- virtual_text = { spacing = 3 },
  virtual_text = false,
  virtual_lines = true, -- enable/disable lsp_lines.nvim plugin
  signs = false,
  underline = true,
  update_in_insert = true,

  vim.fn.sign_define("DiagnosticSignError", { text = " ", texthl = "", numhl = "DiagnosticSignError" }),
  vim.fn.sign_define("DiagnosticSignWarn", { text = " ", texthl = "", numhl = "DiagnosticSignWarn" }),
  vim.fn.sign_define("DiagnosticSignInformation", { text = " ", texthl = "", numhl = "DiagnosticSignInformation" }),
  vim.fn.sign_define("DiagnosticSignHint", { text = " ", texthl = "", numhl = "DiagnosticSignHint" }),
})
vim.cmd "highlight! CmpItemKindSnippet guibg=NONE guifg=#569CD6"
vim.cmd "highlight! CmpItemAbbrMatch guibg=NONE guifg=#569CD6"
vim.cmd "highlight! CmpItemAbbrMatchFuzzy guibg=NONE guifg=#569CD6"
vim.cmd "highlight! CmpItemKindFunction guibg=NONE guifg=#C586C0"
vim.cmd "highlight! CmpItemKindMethod guibg=NONE guifg=#C586C0"
vim.cmd "highlight! CmpItemKindVariable guibg=NONE guifg=#9CDCFE"
vim.cmd "highlight! CmpItemKindKeyword guibg=NONE guifg=#D4D4D4"
