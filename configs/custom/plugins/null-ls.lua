local present, null_ls = pcall(require, "null-ls")

if not present then
  return
end

local b = null_ls.builtins

local sources = {

  -- webdev stuff
  b.formatting.deno_fmt,
  b.formatting.prettier.with { filetypes = { "html", "markdown", "css" } },
  b.formatting.json_tool,

  -- Lua
  -- b.formatting.stylua, -- comment because use sumneko_lua to formatting

  -- Shell
  b.formatting.shfmt,
  b.diagnostics.shellcheck.with { diagnostics_format = "#{m} [#{c}]" },

  -- cpp
  b.formatting.clang_format,

  -- rust
  b.formatting.rustfmt,

  -- crates
  require("crates").setup {
    null_ls = {
      enabled = true,
      name = "crates.nvim",
    },
  },
}

null_ls.setup {
  debug = true,
  sources = sources,
}
