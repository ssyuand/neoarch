M = {}
M.options = {
  -- chadrc
  -- load your options here or load module with options1
  user = function()
    vim.opt.fileencodings = "ucs-bom,utf-8,gbk,big5,latin1"
    vim.opt.expandtab = true
    vim.bo.swapfile = false
    vim.opt.tabstop = 4
    vim.opt.pumheight = 20 -- pop menu height
    vim.opt.scrolloff = 5
    vim.opt.title = true
  end,
  vim.api.nvim_create_autocmd("BufWritePre", {
    command = "lua vim.lsp.buf.formatting_sync(nil, 1000)",
    pattern = "*.cpp,*.css,*.go,*.h,*.html,*.js,*.json,*.jsx,*.lua,*.md,*.py,*.rs,*.ts,*.tsx,*.yaml",
  }),

  nvChad = {
    -- updater
    update_url = "https://github.com/NvChad/NvChad",
    update_branch = "main",
  },
}

local function border(hl_name)
  return {
    { "╭", hl_name },
    { "─", hl_name },
    { "╮", hl_name },
    { "│", hl_name },
    { "╯", hl_name },
    { "─", hl_name },
    { "╰", hl_name },
    { "│", hl_name },
  }
end

M.plugins = {
  override = {
    ["hrsh7th/nvim-cmp"] = {
      window = {
        documentation = {
          border = border "CmpBorder",
        },
      },
    },
    ["lukas-reineke/indent-blankline.nvim"] = {
      show_current_context_start = false,
    },
    ["nvim-treesitter/nvim-treesitter"] = {
      ensure_installed = { "rust", "toml", "java", "javascript", "python", "c", "cpp", "bash", "lua", "json" },
    },
  },
  remove = {
    "folke/which-key.nvim",
    "kyazdani42/nvim-tree.lua",
    lspconfig = {
      setup_lspconf = "custom.plugins.lspconfig", -- path of lspconfig file
    },
    "NvChad/nvterm",
    "lewis6991/gitsigns.nvim",
  },

  options = {},

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
  theme = "vsc_dark", -- default theme
  transparency = false,
}

M.mappings = require "custom.mappings"

return M
