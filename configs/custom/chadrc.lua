M = {}
local override = require "custom.override"
M.options = {
  user = function()
    vim.opt.fileencodings = "ucs-bom,utf-8,gbk,big5,latin1"
    vim.opt.expandtab = true
    vim.bo.swapfile = false
    vim.opt.tabstop = 4
  end,
}

M.plugins = {
  override = {
    ["williamboman/mason.nvim"] = override.mason,
    ["hrsh7th/nvim-cmp"] = override.cmp,
    ["lukas-reineke/indent-blankline.nvim"] = override.blankline,
    ["nvim-treesitter/nvim-treesitter"] = override.treesitter,
  },
  remove = {
    "folke/which-key.nvim",
    "kyazdani42/nvim-tree.lua",
    "NvChad/nvterm",
    "lewis6991/gitsigns.nvim",
  },
  user = require "custom.plugins",
}

M.ui = {
  hl_override = {
    LineNr = { fg = "#666666" },
    CursorLineNr = { fg = "#AAAAAA" },
  },
  theme_toggle = { "vsc_dark", "vsc_light" },
  theme = "vsc_dark", -- default theme
}

M.mappings = require "custom.mappings"

return M
