local M = {}
--Mapping
vim.keymap.set("v", "<S-Down>", ":m '>+1<CR>gv=gv") -- Moving block up
vim.keymap.set("v", "<S-up>", ":m '<-2<CR>gv=gv") -- Moving block down

M.general = {
  n = {
    [";"] = { ":", opts = {} },
    ["<S-Down>"] = { "<cmd> m .+1 <CR>==", opts = {} },
    ["<S-up>"] = { "<cmd> m .-2 <CR>==", opts = {} },
    ["<C-l>"] = { "<cmd> noh <CR>", opts = {} },

    -- lsp
    ["K"] = { "<cmd>lua vim.lsp.buf.hover()<CR>", opts = {} },
    ["<C-k>"] = { "<cmd>lua vim.lsp.buf.signature_help()<CR>", opts = {} },
    ["gd"] = { "<cmd>lua vim.lsp.buf.definition()<CR>", opts = {} },
    ["gD"] = { "<cmd>lua vim.lsp.buf.declaration()<CR>", opts = {} },
    ["gr"] = { "<cmd>lua vim.lsp.buf.references()<CR>", opts = {} },
    ["gi"] = { "<cmd>lua vim.lsp.buf.implementation()<CR>", opts = {} },
    ["gn"] = { "<cmd>lua vim.lsp.buf.rename()<CR>", opts = {} },
    ["<leader>q"] = { "<cmd>Telescope diagnostics<CR>", opts = {} },
    ["<leader>x"] = { "<cmd>lua vim.diagnostic.open_float(0, { scope = 'line', border = 'single' })<CR>", opts = {} },
    ["<leader>h"] = { "<cmd>lua vim.diagnostic.hide()<CR>", opts = {} }

  },
}

M.lspconfig = {
  -- See `<cmd> :help vim.lsp.*` for documentation on any of the below functions
  n = {
    ["<leader>f"] = {
      function()
        vim.lsp.buf.formatting()
      end,
    },
  },
}

-- build and execute
local lang_maps = {
  cpp = { build = "g++ % -o %:r", exec = "./%:r" },
  typescript = { build = "deno compile %", exec = "deno run %" },
  javascript = { build = "deno compile %", exec = "deno run %" },
  python = { exec = "python %" },
  java = { build = "javac %", exec = "java %:r" },
  sh = { exec = "./%" },
  go = { build = "go build", exec = "go run %" },
  rust = { exec = "cargo run" },
  arduino = {
    build = "arduino-cli compile --fqbn arduino:avr:uno %:r",
    exec = "arduino-cli upload -p /dev/ttyACM0 --fqbn arduino:avr:uno %:r",
  },
}
for lang, data in pairs(lang_maps) do
  if data.build ~= nil then
    vim.api.nvim_create_autocmd(
      "FileType",
      { command = "nnoremap <Leader>b :!" .. data.build .. "<CR>", pattern = lang }
    )
  end
  vim.api.nvim_create_autocmd(
    "FileType",
    { command = "nnoremap <Leader>e :split<CR>:terminal " .. data.exec .. "<CR>", pattern = lang }
  )
end

return M
