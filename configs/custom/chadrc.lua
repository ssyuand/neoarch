M = {}
M.options = {
   -- chadrc
   -- load your options here or load module with options1
   user = function()
      vim.opt.fileencodings = "ucs-bom,utf-8,gbk,big5,latin1"
      vim.opt.expandtab = true
      vim.bo.swapfile = false
      vim.opt.shiftwidth = 4
      vim.opt.pumheight = 20
      vim.opt.scrolloff = 5
   end,

   nvChad = {
      -- updater
      update_url = "https://github.com/NvChad/NvChad",
      update_branch = "main",
   },
}

M.plugins = {
   override = {
      ["lukas-reineke/indent-blankline.nvim"] = {
         show_current_context_start = false,
      },
      ["nvim-treesitter/nvim-treesitter"] = {
         ensure_installed = { "rust", "java", "javascript", "python", "c", "cpp", "bash", "lua", "json" },
      },
   },
   remove = {
      "folke/which-key.nvim",
      "kyazdani42/nvim-tree.lua",
      "NvChad/nvterm",
      "lewis6991/gitsigns.nvim",
      "nvim-telescope/telescope.nvim",
   },

   options = {
      lspconfig = {
         setup_lspconf = "custom.plugins.lspconfig", -- path of lspconfig file
      },
      statusline = {
         separator_style = "block", -- default/round/block
      },
   },

   -- add, modify, remove plugins
   user = require "custom.plugins",
}

---- UI -----
M.ui = {
   hl_override = {
      LineNr = { fg = "#252525" },
      CursorLineNr = { fg = "#c6c6c6" },
   },
   changed_themes = {},
   theme_toggle = { "vsc_dark", "vsc_light" },
   theme = "vsc_light", -- default theme
   transparency = false,
}

M.mappings = require "custom.mappings"

return M
