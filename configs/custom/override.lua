local M = {}
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

M.mason = {
  ensure_installed = {
    -- lua stuff
    "lua-language-server",

    -- web dev
    "css-lsp",
    "html-lsp",
    "typescript-language-server",
    "deno",
    "emmet-ls",
    "json-lsp",

    -- shell
    "shfmt",
    "bash-language-server",

    -- rust
    "rust-analyzer",

    -- java
    "jdtls",
  },
}
M.cmp = {
  window = {
    documentation = {
      border = border "CmpBorder",
    },
  },
}
M.blankline = {
  show_current_context_start = false,
}
M.treesitter = {
  ensure_installed = { "rust", "toml", "java", "javascript", "python", "c", "cpp", "bash", "lua", "json" },
}
return M
