vim.lsp.handlers['textDocument/publishDiagnostics'] = vim.lsp.with(vim.lsp.diagnostic.on_publish_diagnostics, {
  virtual_text = { spacing= 3 },
  signs = true,
  underline = true,
  update_in_insert = false,

vim.fn.sign_define("DiagnosticSignError",
    {text = " ", texthl = "", numhl = "DiagnosticSignError"}),
vim.fn.sign_define("DiagnosticSignWarn",
    {text = " ", texthl = "", numhl ="DiagnosticSignWarn" }),
vim.fn.sign_define("DiagnosticSignInformation",
    {text = " ", texthl = "", numhl = "DiagnosticSignInformation"}),
vim.fn.sign_define("DiagnosticSignHint",
    {text = " ", texthl = "", numhl = "DiagnosticSignHint"})
})


--mapping
local key_map = function(mode, key, result)
	vim.api.nvim_set_keymap(mode, key, result, {noremap = true, silent = true})
end

key_map('n', 'gD', '<cmd>lua vim.lsp.buf.declaration()<CR>')
key_map('n', 'gd', ':lua vim.lsp.buf.definition()<CR>')
key_map('n', 'K', '<cmd>lua vim.lsp.buf.hover()<CR>')
key_map('n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<CR>')
key_map('n', '<C-k>', '<cmd>lua vim.lsp.buf.signature_help()<CR>')
key_map('n', '<space>wa', '<cmd>lua vim.lsp.buf.add_workspace_folder()<CR>')
key_map('n', '<space>wr', '<cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>')
key_map('n', '<space>wl', '<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>')
key_map('n', '<space>D', '<cmd>lua vim.lsp.buf.type_definition()<CR>')
key_map('n', '<space>rn', '<cmd>lua vim.lsp.buf.rename()<CR>')
key_map('n', '<space>ca', '<cmd>lua vim.lsp.buf.code_action()<CR>')
key_map('n', 'gr', '<cmd>lua vim.lsp.buf.references()<CR>')
key_map('n', '<space>e', '<cmd>lua vim.lsp.diagnostic.show_line_diagnostics()<CR>')
key_map('n', '[d', '<cmd>lua vim.lsp.diagnostic.goto_prev()<CR>')
key_map('n', ']d', '<cmd>lua vim.lsp.diagnostic.goto_next()<CR>')
key_map('n', '<space>q', '<cmd>lua vim.lsp.diagnostic.set_loclist()<CR>')
key_map('n', '<space>f', '<cmd>lua vim.lsp.buf.formatting()<CR>')
