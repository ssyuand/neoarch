local M = {}
--Mapping
vim.keymap.set("v", "<S-Down>", ":m '>+1<CR>gv=gv") -- Moving block up
vim.keymap.set("v", "<S-up>", ":m '<-2<CR>gv=gv") -- Moving block down

M.general = {
  n = {
    [";"] = { ":", opts = {} },
    ["<C-l>"] = { "<cmd> noh <CR>", opts = {} },
    ["<S-Down>"] = { "<cmd> m .+1 <CR>==", opts = {} },
    ["<S-up>"] = { "<cmd> m .-2 <CR>==", opts = {} },

    -- lsp
    ["K"] = { "<cmd>lua vim.lsp.buf.hover()<CR>", opts = {} },
    ["<C-k>"] = { "<cmd>lua vim.lsp.buf.signature_help()<CR>", opts = {} },
    ["gd"] = { "<cmd>lua vim.lsp.buf.definition()<CR>", opts = {} },
    ["gD"] = { "<cmd>lua vim.lsp.buf.declaration()<CR>", opts = {} },
    ["gr"] = { "<cmd>lua vim.lsp.buf.references()<CR>", opts = {} },
    ["gi"] = { "<cmd>lua vim.lsp.buf.implementation()<CR>", opts = {} },
    ["gn"] = { "<cmd>lua vim.lsp.buf.rename()<CR>", opts = {} },
    ["<leader>fm"] = { "<cmd>lua vim.lsp.buf.formatting()<CR>", opts = {} },
    ["<leader>q"] = { "<cmd>Telescope diagnostics<CR>", opts = {} },
    ["<leader>x"] = { "<cmd>lua vim.diagnostic.open_float(0, { scope = 'line', border = 'single' })<CR>", opts = {} },
    ["<leader>h"] = { "<cmd>lua vim.diagnostic.hide()<CR>", opts = {} },

  },
}

return M
