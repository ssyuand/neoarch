require("bufferline").setup {
	options = {
		tab_size = 6;
		buffer_close_icon = ' ',
		close_icon = ' ',
		diagnostics = "nvim_lsp",
		diagnostics_update_in_insert = false,
		show_tab_indicators = true,
		always_show_bufferline = false;

	}
}
local key_map = function(mode, key, result)
	vim.api.nvim_set_keymap(mode, key, result, { noremap = true, silent = true })
end
key_map('n', '<TAB>', '<cmd>BufferLineCycleNext<CR>')
key_map('n', '<s-tab>', '<cmd>BufferLineCyclePrev<cr>')
key_map('n', '<C-w>', '<cmd>bd<CR>')
