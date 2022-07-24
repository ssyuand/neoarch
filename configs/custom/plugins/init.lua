return {
  ["https://git.sr.ht/~whynothugo/lsp_lines.nvim"] = {
    config = function()
      require("lsp_lines").register_lsp_virtual_lines()
    end,
  },
  ["neovim/nvim-lspconfig"] = {
    config = function()
      require "custom.plugins.lspconfig"
    end,
  },
  ["saecki/crates.nvim"] = {},
  ["jose-elias-alvarez/null-ls.nvim"] = {
    after = "nvim-lspconfig",
    config = function()
      require "custom.plugins.null-ls"
    end,
  },
  ["hoob3rt/lualine.nvim"] = {
    config = function()
      require "custom.plugins.lualine"
    end,
  },
}
