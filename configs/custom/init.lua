local user_cmd = vim.api.nvim_create_user_command
local auto_cmd = vim.api.nvim_create_autocmd
auto_cmd("BufWritePre", {
  command = "lua vim.lsp.buf.formatting_sync(nil, 1000)",
  -- pattern = "*.cpp,*.css,*.go,*.h,*.html,*.js,*.json,*.jsx,*.lua,*.md,*.py,*.rs,*.ts,*.tsx,*.yaml, *.sh",
  pattern = "*",
})

local attach_to_buffer = function(bufnr, pattern, command)
  auto_cmd("BufWritePost", {
    group = vim.api.nvim_create_augroup("foo", { clear = true }),
    pattern = pattern,
    callback = function()
      local append_data = function(_, data)
        if data then
          vim.api.nvim_buf_set_lines(bufnr, -1, -1, false, data)
        end
      end
      vim.api.nvim_buf_set_lines(bufnr, 0, -1, false, { "output:" })
      vim.fn.jobstart(command, {
        stdout_buffered = true,
        on_stdout = append_data,
        on_stderr = append_data,
      })
    end,
  })
end

user_cmd("AutoRun", function()
  print("run")
  local bufnr = vim.fn.input "Bufnr: "
  local pattern = vim.fn.input "pattern: "
  local command = vim.split(vim.fn.input "command: ", " ")
  attach_to_buffer(tonumber(bufnr), pattern, command)
end, {})
