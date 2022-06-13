local M = {}

M.setup_lsp = function(attach, capabilities)
   local lspconfig = require "lspconfig"

   -- lspservers with default config
   local servers = { "bashls", "jdtls", "clangd", "pyright", "tsserver" }

   for _, lsp in ipairs(servers) do
      lspconfig[lsp].setup {
         on_attach = attach,
         capabilities = capabilities,
      }
   end
end

vim.lsp.handlers['textDocument/publishDiagnostics'] = vim.lsp.with(vim.lsp.diagnostic.on_publish_diagnostics, {
    virtual_text = { spacing = 3 },
    signs = true,
    underline = true,
    update_in_insert = false,

    vim.fn.sign_define("DiagnosticSignError",
        { text = " ", texthl = "", numhl = "DiagnosticSignError" }),
    vim.fn.sign_define("DiagnosticSignWarn",
        { text = " ", texthl = "", numhl = "DiagnosticSignWarn" }),
    vim.fn.sign_define("DiagnosticSignInformation",
        { text = " ", texthl = "", numhl = "DiagnosticSignInformation" }),
    vim.fn.sign_define("DiagnosticSignHint",
        { text = " ", texthl = "", numhl = "DiagnosticSignHint" })
})
vim.cmd('highlight! CmpItemKindSnippet guibg=NONE guifg=#569CD6')
vim.cmd('highlight! CmpItemAbbrMatch guibg=NONE guifg=#569CD6')
vim.cmd('highlight! CmpItemAbbrMatchFuzzy guibg=NONE guifg=#569CD6')
vim.cmd('highlight! CmpItemKindFunction guibg=NONE guifg=#C586C0')
vim.cmd('highlight! CmpItemKindMethod guibg=NONE guifg=#C586C0')
vim.cmd('highlight! CmpItemKindVariable guibg=NONE guifg=#9CDCFE')
vim.cmd('highlight! CmpItemKindKeyword guibg=NONE guifg=#D4D4D4')
return M


