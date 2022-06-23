return {
   ["dstein64/vim-startuptime"] = {},
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
