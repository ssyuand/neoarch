return {
  ["https://git.sr.ht/~whynothugo/lsp_lines.nvim"] = {
    config = function()
      require("lsp_lines").setup()
    end,
  },
  ["neovim/nvim-lspconfig"] = {
    config = function()
      require "plugins.configs.lspconfig"
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
  ["nvim-treesitter/nvim-treesitter"] = {
    run = ':TSUpdate',
    config = function() require('nvim-treesitter.configs').setup({
        ensure_installed = { "lua" },
        sync_install = true,
        auto_install = true,
      })
    end,
  }
}
