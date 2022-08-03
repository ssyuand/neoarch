local user_cmd = vim.api.nvim_create_user_command
local auto_cmd = vim.api.nvim_create_autocmd
local execute = vim.api.nvim_command
auto_cmd("BufWritePre", {
  command = "lua vim.lsp.buf.formatting_sync(nil, 1000)",
  pattern = "*",
})

local attach_to_buffer = function(bufnr, pattern, command)
  auto_cmd("BufWritePost", {
    group = vim.api.nvim_create_augroup("foo", { clear = true }),
    pattern = pattern,
    callback = function()
      local append_data = function(_, data)
        if data then
          -- vim.api.nvim_buf_set_lines(bufnr, -1, -1, false, data) -- refresh
          vim.api.nvim_buf_set_lines(bufnr, 1, 1, false, data) -- no refresh
        end
      end
      vim.api.nvim_buf_set_lines(bufnr, 0, 0, false, { "----------" })
      vim.fn.jobstart(command, {
        stdout_buffered = true,
        on_stdout = append_data,
        on_stderr = append_data,
      })
    end,
  })
end

user_cmd("AutoRun", function()
  execute("vnew")
  local bufnr = vim.api.nvim_get_current_buf()
  local pattern = vim.fn.expand('%')
  local command = vim.fn.input "command: "
  attach_to_buffer(tonumber(bufnr), pattern, command)
end, {})
